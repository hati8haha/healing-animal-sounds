import 'package:flutter/material.dart';
import '../components/count_down_timer.dart';
// ignore: depend_on_referenced_packages
import 'package:audioplayers/audioplayers.dart';

class SoundPage extends StatefulWidget {
  @override
  State<SoundPage> createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  bool showMusicMenu = false;
  bool showBgMenu = false;
  bool showFilterMenu = false;

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/images/background/pink-grass-sea.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
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
                SizedBox(height: 50),
                Column(
                  children: [
                    CountdownTimer(),
                    SizedBox(
                      height: 56,
                      child: ListTile(
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              showMusicMenu = !showMusicMenu;
                              showFilterMenu = false;
                              showBgMenu = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(100, 101, 110, 119),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.music_video),
                          ),
                        ),
                        subtitle: Visibility(
                          visible: showMusicMenu,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                color: Colors.grey,
                                width: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Column(
                                    children: [
                                      Text('Option 1'),
                                      Text('Option 2'),
                                      Text('Option 3'),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 56,
                      child: ListTile(
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              showBgMenu = !showBgMenu;
                              showFilterMenu = false;
                              showMusicMenu = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(100, 101, 110, 119),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.forest),
                          ),
                        ),
                        subtitle: Visibility(
                          visible: showBgMenu,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                  color: Colors.grey,
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Text('Option 1'),
                                      Text('Option 2'),
                                      Text('Option 3'),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 56,
                      child: ListTile(
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              showFilterMenu = !showFilterMenu;
                              showMusicMenu = false;
                              showBgMenu = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(100, 101, 110, 119),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.filter_list),
                          ),
                        ),
                        subtitle: Visibility(
                          visible: showFilterMenu,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                  color: Colors.grey,
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Text('Option 1'),
                                      Text('Option 2'),
                                      Text('Option 3'),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/images/animals/bird.png',
                        height: 300.0,
                        width: 300.0,
                      ),
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
}
