// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Components imports
import 'package:digital_clock/digit.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Color(0xFF174EA6),
};

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  StreamController _hourLController = StreamController<int>.broadcast();
  StreamController _hourRController = StreamController<int>.broadcast();
  StreamController _minLController = StreamController<int>.broadcast();
  StreamController _minRController = StreamController<int>.broadcast();
  StreamController _secLController = StreamController<int>.broadcast();
  StreamController _secRController = StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();

    _hourLController.close();
    _hourRController.close();
    _minLController.close();
    _minRController.close();
    _secLController.close();
    _secRController.close();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    _dateTime = DateTime.now();
    // Update once per minute. If you want to update every second, use the
    // following code.
//      _timer = Timer(
//        Duration(minutes: 1) -
//            Duration(seconds: _dateTime.second) -
//            Duration(milliseconds: _dateTime.millisecond),
//        _updateTime,
//      );
    // Update once per second, but make sure to do it at the beginning of each
    // new second, so that the clock is accurate.
    _timer = Timer(
      Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      _updateTime,
    );
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final second = DateFormat('ss').format(_dateTime);

    _hourLController.add(int.parse(hour[0]));
    _hourRController.add(int.parse(hour[1]));
    _minLController.add(int.parse(minute[0]));
    _minRController.add(int.parse(minute[1]));
    _secLController.add(int.parse(second[0]));
    _secRController.add(int.parse(second[1]));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

//    final fontSize = MediaQuery.of(context).size.width / 3.5;
//    final offset = -fontSize / 7;
//    final defaultStyle = TextStyle(
//      color: colors[_Element.text],
//      fontFamily: 'PressStart2P',
//      fontSize: fontSize,
//      shadows: [
//        Shadow(
//          blurRadius: 0,
//          color: colors[_Element.shadow],
//          offset: Offset(10, 0),
//        ),
//      ],
//    );

//    return Container(
//      color: colors[_Element.background],
//      child: Center(
//        child: DefaultTextStyle(
//          style: defaultStyle,
//          child: Stack(
//            children: <Widget>[
//              Positioned(left: offset, top: 0, child: Text(hour)),
//              Positioned(right: offset, bottom: offset, child: Text(minute)),
//            ],
//          ),
//        ),
//      ),
//    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return Container(
        color: Colors.white,
        child: Center(
            child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Digit(stream: _hourLController.stream),
          Padding(padding: EdgeInsets.all(7.5)),
          Digit(stream: _hourRController.stream),
          Padding(padding: EdgeInsets.all(5.0)),
          Colon(),
          Padding(padding: EdgeInsets.all(5.0)),
          Digit(stream: _minLController.stream),
          Padding(padding: EdgeInsets.all(7.5)),
          Digit(stream: _minRController.stream),
          Padding(padding: EdgeInsets.all(5.0)),
          Colon(),
          Padding(padding: EdgeInsets.all(5.0)),
          Digit(stream: _secLController.stream),
          Padding(padding: EdgeInsets.all(7.5)),
          Digit(stream: _secRController.stream)
        ])));
  }
}
