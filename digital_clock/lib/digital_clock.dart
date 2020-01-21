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
import 'package:digital_clock/colon.dart';
import 'package:digital_clock/info_panel.dart';

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
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.dispose();

    _hourLController.close();
    _hourRController.close();
    _minLController.close();
    _minRController.close();
    _secLController.close();
    _secRController.close();
    super.dispose();
  }

  void _updateTime() {
    _dateTime = DateTime.now();

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
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Container(
        color: isLightTheme ? Colors.white : Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                ]),
            InfoPanel(
                temperature: widget.model.temperatureString,
                weather: widget.model.weatherString,
                location: widget.model.location)
          ],
        ));
  }
}
