import 'package:flutter/material.dart';

class BackToTopIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_upward),
          color: Colors.black,
          onPressed: () {
            // Implement your functionality here
          },
        ),
      ),
    );
  }
}