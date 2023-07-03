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
  bool showMusicMenu = false;
  bool showBgMenu = false;
  bool showFilterMenu = false;
  final String modelViewerScript =
      'const modelViewer=document.querySelector("model-viewer"),defaultAction="Idle_A",actions=["Attack","Bounce","Clicked","Death","Eat","Fear","Fly","Hit","Idle_B","Idle_C","Jump","Roll","Run","Sit","Spin","Swim","Walk"];function randomAction(){return actions[Math.round(Math.random()*(actions.length-1))]}modelViewer.addEventListener("click",function(){modelViewer.animationName=randomAction(),setTimeout(function(){modelViewer.animationName="Idle_A"},2e3)});';

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
