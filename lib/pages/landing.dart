import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var _controller;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
                ElevatedButton(
                    onPressed: () {
                      _controller?.runJavascript('''
sayHello();
''');
                    },
                    child: const Text("Run Function")),
                SizedBox(
                    height: 400,
                    width: 400,
                    child: BabylonJSViewer(
                      controller: (WebViewController controller) {
                        _controller = controller;
                      },
                      functions:
                          '''function sayHello() { Print.postMessage("Hello World!"); }''',
                      src: 'assets/animals/ArcticFox_Animations.glb',
                    ))
              ],
            ))),
      ),
    );
  }
}
