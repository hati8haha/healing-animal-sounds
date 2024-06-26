import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:healing_animal_sounds/pages/setting.dart';
import 'package:healing_animal_sounds/pages/sound.dart';
import 'package:healing_animal_sounds/utils/ad_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  late InterstitialAd _interstitialAd;

  // ignore: unused_field
  bool _isInterstitialAdReady = false;

  // ignore: unused_field
  bool _isRewardedAdReady = false;

  // ignore: unused_field
  RewardedAd? _rewardedAd;
  String selectCategory = '全部';
  List<String> lockAnimails = ['WhiteCat_Animations', 'Walrus_Animations'];
  final List<String> buttonLabels = [
    '全部',
    '肉食系',
    '草食系',
    '雜食系',
  ];
  Map<String, List<String>> animalsMap = {
    '肉食系': ['Snake_Animations', 'WhiteCat_Animations'],
    '草食系': ['Tortoise_Animations'],
    '雜食系': [
      'Crow_Animations',
      'Elephant_Animations',
      'Husky_Animations',
      'Rhino_Animations',
      'Walrus_Animations'
    ],
  };

  void setTotalCategory() {
    List<String> allValues = [];
    animalsMap.forEach((key, value) {
      allValues.addAll(value);
    });

    animalsMap['全部'] = allValues;
  }

  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setTotalCategory();

    _bannerAd = BannerAd(
        // Change Banner Size According to Ur Need
        size: AdSize.fullBanner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        }, onAdFailedToLoad: (ad, LoadAdError error) {
          print("Failed to Load A Banner Ad${error.message}");
          _isBannerAdReady = false;
          ad.dispose();
        }),
        request: AdRequest())
      ..load();
    //Interstitial Ads
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        }, onAdFailedToLoad: (LoadAdError error) {
          print("failed to Load Interstitial Ad ${error.message}");
        }));

    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    if (Platform.isAndroid) {
      RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          _rewardedAd = ad;
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            setState(() {
              _isRewardedAdReady = false;
            });
            _loadRewardedAd();
          });
          setState(() {
            _isRewardedAdReady = true;
          });
        }, onAdFailedToLoad: (error) {
          print('Failed to load a rewarded ad: ${error.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        }),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToSelectedButton() {
    if (selectedIndex > 0) {
      const double buttonWidth = 100.0;
      final double scrollOffset =
          (selectedIndex * buttonWidth) - (2 * buttonWidth);
      final double maxScrollExtent = _scrollController.position.maxScrollExtent;

      if (scrollOffset < maxScrollExtent) {
        _scrollController.animateTo(
          scrollOffset,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _scrollController.animateTo(
          maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onTapAnimalBox(int index) {
    String animalName = animalsMap[selectCategory]!.elementAt(index);
    if (lockAnimails.contains(animalName)) {
      showVIPDialog();
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SoundPage(
                  animalName: animalName,
                )),
      );
    }
  }

  void showVIPDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/others/animal_bg.png'),
              SizedBox(height: 8),
              Text('免廣告！！'),
              Text('解鎖更多療癒動物！！'),
              Text(
                '超過50+種動物聲音陪伴你的每一天',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            VipDialog(
              onPressed: () {
                // go to VIP page
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('動物白噪音'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/images/background/dark_grassland.png'
                            : 'assets/images/background/home-bg.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Row(
                        children: [
                          for (int index = 0;
                              index < buttonLabels.length;
                              index++)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: ChoiceChip(
                                label: Text(buttonLabels[index]),
                                selected: selectedIndex == index,
                                onSelected: (bool selected) {
                                  setState(() {
                                    selectedIndex = selected ? index : -1;
                                    selectCategory = buttonLabels[index];
                                  });
                                  scrollToSelectedButton();
                                },
                                side: BorderSide(style: BorderStyle.none),
                                elevation: 2,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(
                            animalsMap[selectCategory]!.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: GestureDetector(
                                onTap: () => onTapAnimalBox(index),
                                child: AnimalBox(
                                  animalsMap: animalsMap,
                                  selectCategory: selectCategory,
                                  lockAnimails: lockAnimails,
                                  index: index,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  if (Platform.isAndroid && _isBannerAdReady)
                    SizedBox(
                      height: _bannerAd.size.height.toDouble(),
                      width: MediaQuery.of(context).size.width,
                      child: AdWidget(ad: _bannerAd),
                    ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  showVIPDialog();
                },
                child: Image.asset(
                  'assets/images/others/vip.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalBox extends StatelessWidget {
  const AnimalBox({
    super.key,
    required this.animalsMap,
    required this.selectCategory,
    required this.lockAnimails,
    required this.index,
  });

  final Map<String, List<String>> animalsMap;
  final String selectCategory;
  final List<String> lockAnimails;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(
                'assets/images/animals/${animalsMap[selectCategory]!.elementAt(index)}.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        if (lockAnimails
            .contains(animalsMap[selectCategory]!.elementAt(index))) // 條件判斷
          Center(
            child: Container(
              color: Colors.black.withOpacity(0.5), // 設定透明度
              child: Text(
                '升級為VIP解鎖',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class VipDialog extends StatelessWidget {
  final VoidCallback onPressed;

  const VipDialog({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: TextButton(
        onPressed: onPressed,
        child: const Text('升級VIP', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

