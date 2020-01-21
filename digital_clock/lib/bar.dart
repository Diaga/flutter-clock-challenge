import 'package:flutter/material.dart';
import 'package:digital_clock/block.dart';


/// [Bar] widget uses two [Block] widgets and serves as one of the seven
/// identical widgets of a digit.
class Bar extends StatelessWidget {
  final isRow;
  final isOn;

  final double minSize = 2.0;
  final double maxSize = 29.0;
  final double reduceFactor = 0.5;

  const Bar({Key key, this.isRow = false, this.isOn = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = 0.0;
    var height = 0.0;
    if (this.isRow) {
      width = this.isOn ? maxSize : maxSize * reduceFactor;
      height = minSize;
    } else {
      width = minSize;
      height = this.isOn ? maxSize : maxSize * reduceFactor;
    }

    return Container(
      width: this.isRow ? maxSize * 2 : 2.0,
      height: this.isRow ? 2.0 : maxSize * 2,
      child: this.isRow
          ? Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Block(width: width, height: height, isOn: this.isOn),
          Block(width: width, height: height, isOn: this.isOn),
        ],
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Block(width: width, height: height, isOn: this.isOn),
          Block(width: width, height: height, isOn: this.isOn),
        ],
      ),
    );
  }
}
