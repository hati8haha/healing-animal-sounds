import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
                Image(
                    image: AssetImage('assets/images/animals/bird.png'),
                    fit: BoxFit.fitHeight),
              ],
            ))),
      ),
    );
  }
}
