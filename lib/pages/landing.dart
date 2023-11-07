import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background/grass-sea.png'),
                fit: BoxFit.cover)),
        child: Center(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: (Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('App name'),
                  Text('小動物們蠢蠢欲動了！'),
                  Text('今天陪伴你的會是誰呢？'),
                  SizedBox(
                    width: 400,
                    height: 400,
                    child: ModelViewer(
                      src: 'assets/animals/Dove_Animations.gltf',
                      autoPlay: true,
                      animationName: 'Idle_A',
                      animationCrossfadeDuration: 1000,
                      touchAction: TouchAction.none,
                    ),
                 
                  ),
                     IconButton(
                        icon: Icon(
                              Icons.arrow_circle_right,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            iconSize: 80,
                    )
                ],
              ))),
        ),
      ),
    );
  }
}
