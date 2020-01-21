import 'package:flutter/material.dart';

/// Basic widget that serves as a building block for all of the digital clock
/// widgets.
class Block extends StatelessWidget {
  final double width;
  final double height;
  final bool isOn;

  const Block({Key key, this.isOn, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: this.isOn
                ? Colors.black.withAlpha(255)
                : isLightTheme
                    ? Colors.black.withAlpha(50)
                    : Colors.white.withAlpha(50),
            shape: BoxShape.rectangle,
            boxShadow: [
              isLightTheme
                  ? BoxShadow(
                      color: Colors.white
                          .withAlpha(this.isOn ? 255 : 0)
                          .withRed(0),
                      blurRadius: 2.0,
                      spreadRadius: 1.0)
                  : BoxShadow(
                      color: Colors.white
                          .withAlpha(this.isOn ? 255 : 0)
                          .withRed(57)
                          .withGreen(255)
                          .withBlue(20),
                      blurRadius: 2.0,
                      spreadRadius: 3.0,
                    ),
            ]));
  }
}
