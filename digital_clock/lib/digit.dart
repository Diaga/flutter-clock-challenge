import 'package:flutter/material.dart';
import 'package:digital_clock/bar.dart';

/// [Digit] widget utilizes seven [Bar] widgets to make a digit from 0 to 9.
class Digit extends StatelessWidget {
  final stream;
  final digitConfig = const {
    0: [true, true, true, false, true, true, true],
    1: [false, false, true, false, false, true, false],
    2: [true, false, true, true, true, false, true],
    3: [true, false, true, true, false, true, true],
    4: [false, true, true, true, false, true, false],
    5: [true, true, false, true, false, true, true],
    6: [true, true, false, true, true, true, true],
    7: [true, false, true, false, false, true, false],
    8: [true, true, true, true, true, true, true],
    9: [true, true, true, true, false, true, true]
  };

  const Digit({Key key, this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: this.stream.distinct(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Bar(isRow: true, isOn: digitConfig[snapshot.data][0]),
                      Container(
                        width: 65.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Bar(
                              isOn: digitConfig[snapshot.data][1],
                            ),
                            Bar(isOn: digitConfig[snapshot.data][2])
                          ],
                        ),
                      ),
                      Bar(isRow: true, isOn: digitConfig[snapshot.data][3]),
                      Container(
                        width: 65.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Bar(isOn: digitConfig[snapshot.data][4]),
                            Bar(isOn: digitConfig[snapshot.data][5])
                          ],
                        ),
                      ),
                      Bar(
                        isRow: true,
                        isOn: digitConfig[snapshot.data][6],
                      ),
                    ])
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Bar(isRow: true),
                      Container(
                        width: 65.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[Bar(), Bar()],
                        ),
                      ),
                      Bar(isRow: true),
                      Container(
                        width: 65.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[Bar(), Bar()],
                        ),
                      ),
                      Bar(isRow: true),
                    ]);
        });
  }
}
