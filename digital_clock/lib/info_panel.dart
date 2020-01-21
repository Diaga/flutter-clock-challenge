import 'package:flutter/material.dart';

/// Info Panel that takes in values of temperature, weather and location
/// and displays them as required.
class InfoPanel extends StatelessWidget {
  final temperature;
  final weather;
  final location;

  const InfoPanel({Key key, this.temperature, this.weather, this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
            '$temperature ,  ${weather[0].toUpperCase()}${weather.substring(1)}',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, shadows: [])),
        Padding(padding: EdgeInsets.all(2)),
        Text(
          location,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
