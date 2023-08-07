import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _secondsRemaining = 5000;
  int _hour = 1;
  int _minutes = 23;
  int _seconds = 20;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          _hour = (_secondsRemaining ~/ 3600).toInt();
          _minutes = ((_secondsRemaining ~/ 60) % 60).toInt();
          _seconds = (_secondsRemaining % 60).toInt();
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedHour = _hour.toString().padLeft(2, '0');
    String formattedMinutes = _minutes.toString().padLeft(2, '0');
    String formattedSeconds = _seconds.toString().padLeft(2, '0');

    return Text(
      '$formattedHour : $formattedMinutes : $formattedSeconds',
      style: TextStyle(
        fontSize: 32,
        fontFamily: 'MonomaniacOne',
        color: Colors.white,
      ),
    );
  }
}
