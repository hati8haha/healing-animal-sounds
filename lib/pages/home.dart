import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttonLabels = [
    '全部',
    '森林',
    '地獄生物',
    '吉娃娃',
    '蘿莉',
    '正太',
    '御姊',
    '萌妹'
  ];
  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[300],
          title: Text('動物白噪音'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                // Add your onPressed logic here
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/home-bg.png'),
              fit: BoxFit.cover,
            ),
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
                      for (int index = 0; index < buttonLabels.length; index++)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: ChoiceChip(
                            backgroundColor: Colors.white,
                            label: Text(buttonLabels[index]),
                            selected: selectedIndex == index,
                            selectedColor: Colors.blue,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedIndex = selected ? index : -1;
                              });
                              scrollToSelectedButton();
                            },
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
                    children: List.generate(8, (index) {
                      return Center(
                        child: Image.asset(
                          'assets/images/animals/bird.png', // Replace with your image asset path
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image(image: AssetImage("assets/images/others/vip.png")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
