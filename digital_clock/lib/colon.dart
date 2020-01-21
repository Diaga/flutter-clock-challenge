import 'package:flutter/material.dart';
import 'package:digital_clock/block.dart';

/// Built out of [Block] widget, [Colon] widget serves as a distinction
/// between hours and minutes, minutes and seconds.
class Colon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Block(
          width: 10,
          height: 10,
          isOn: true,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Block(
          width: 10,
          height: 10,
          isOn: true,
        )
      ],
    );
  }
}