import 'dart:ui';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
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
                Image(
                    image: AssetImage('assets/images/animals/bird.png'),
                    fit: BoxFit.fitHeight),
              ],
            ))),
      ),
    );
  }
}
