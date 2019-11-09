import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/material.dart';

class FlipClockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
        child: FlipClock.simple(
          startTime: DateTime.now(),
          digitColor: Colors.white,
          backgroundColor: Colors.black,
          digitSize: 10.0,
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        ),
      );
  }
}