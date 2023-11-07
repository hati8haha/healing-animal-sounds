import 'package:flutter/material.dart';
import '../components/count_down_timer.dart';
// ignore: depend_on_referenced_packages
import 'package:audioplayers/audioplayers.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class SoundPage extends StatefulWidget {
  final String animalName;

  const SoundPage({
    super.key,
    required this.animalName,
  });

  @override
  State<SoundPage> createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  bool showMenuList = false;
  bool showMusicMenu = false;
  bool showBgMenu = false;
  bool showFilterMenu = false;
  final String modelViewerScript =
      'const modelViewer=document.querySelector("model-viewer"),defaultAction="Idle_A",actions=["Attack","Bounce","Clicked","Death","Eat","Fear","Fly","Hit","Idle_B","Idle_C","Jump","Roll","Run","Sit","Spin","Swim","Walk"];function randomAction(){return actions[Math.round(Math.random()*(actions.length-1))]}modelViewer.addEventListener("click",function(){modelViewer.animationName=randomAction(),setTimeout(function(){modelViewer.animationName="Idle_A"},2e3)});';
  String selectedOption = 'pink-grass-sea.png';
  int selectDuration = 3600;
  List<String> backgroundImages = ['粉色濱海', '金色濱海', '粉色草原', '金色草原', '粉色海洋'];
  List<String> backgroundMusic = ['平靜音樂', '節奏音樂', '輕快音樂'];
  List<String> filterDutation = ['30 min', '1 hr', '2 hrs', '3 hrs'];
  Map<String, String> optionImages = {
    '粉色濱海': 'pink-grass-sea.png',
    '金色濱海': 'grass-sea.png',
    '粉色草原': 'golden-grass-sea.png',
    '金色草原': 'golden-sea.png',
    '粉色海洋': 'pink-sea.png',
  };
  Map<String, String> optionMusic = {
    '平靜音樂': 'song.mp3',
    '節奏音樂': 'song2.mp3',
    '輕快音樂': 'song3.mp3',
  };
  Map<String, int> optionDuration = {
    '30 min': 1800,
    '1 hr': 3600,
    '2 hrs': 7200,
    '3 hrs': 10800,
  };

  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    player.play(AssetSource('audio/song.mp3'));
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              setState(() {
                showMenuList = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background/$selectedOption'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                          child: ModelViewer(
                              src: 'assets/animals/${widget.animalName}.gltf',
                              autoPlay: true,
                              animationName: 'Idle_A',
                              animationCrossfadeDuration: 1000,
                              touchAction: TouchAction.none,
                              cameraOrbit: "45deg 65deg 10m",
                              cameraTarget: '0 1m 0',
                              disableTap: true,
                              relatedJs: modelViewerScript),
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 10.0),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_left,
                                ))
                          ],
                        ),
                      ),
                      Center(child: CountdownTimer(duration: selectDuration)),
                      SizedBox(height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showMenuList = !showMenuList;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(100, 101, 110, 119),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.expand_more),
                            ),
                          ),
                          if (showMenuList)
                            Container(
                              width: 175,
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView(
                                padding: EdgeInsets.all(8),
                                shrinkWrap: true,
                                children: [
                                  _buildExpansionTile('音樂', backgroundMusic),
                                  _buildExpansionTile('背景', backgroundImages),
                                  _buildExpansionTile('時間', filterDutation),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildExpansionTile(String title, List<String> items) {
    return ExpansionTile(
      title: Text(title),
      children: [
        SizedBox(
          height: 100,
          child: SingleChildScrollView(
            child: Column(
              children: items
                  .map((item) => ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() async {
                            if (title == '音樂') {
                              await player.stop();
                              String path = optionMusic[item]!;
                              await player.play(AssetSource('audio/$path'));
                            } else if (title == '背景') {
                              selectedOption = optionImages[item]!;
                            } else if (title == '時間') {
                              selectDuration = optionDuration[item]!;
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
