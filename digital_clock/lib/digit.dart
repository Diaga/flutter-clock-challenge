import 'package:flutter/material.dart';

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

class Bar extends StatefulWidget {
  final isRow;
  final isOn;

  const Bar({Key key, this.isRow = false, this.isOn = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BarState();
}

class _BarState extends State<Bar> with SingleTickerProviderStateMixin {
  final double minSize = 2.0;
  final double maxSize = 29.0;
  final double reduceFactor = 0.0;

  AnimationController sizeController;

  double width = 0.0;
  double height = 0.0;
  bool wasOn;

  @override
  Widget build(BuildContext context) {
    if (this.widget.isOn != this.wasOn) {
      this.wasOn = this.widget.isOn;
    }

    if (this.widget.isRow) {
      this.width = this.widget.isOn ? maxSize : maxSize * reduceFactor;
      this.height = minSize;
    } else {
      this.width = minSize;
      this.height = this.widget.isOn ? maxSize : maxSize * reduceFactor;
    }

    return Container(
      width: this.widget.isRow ? maxSize * 2 : 2.0,
      height: this.widget.isRow ? 2.0 : maxSize * 2,
      child: this.widget.isRow
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Block(
                    width: this.width,
                    height: this.height,
                    isOn: this.widget.isOn),
                Block(
                    width: this.width,
                    height: this.height,
                    isOn: this.widget.isOn),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Block(
                    width: this.width,
                    height: this.height,
                    isOn: this.widget.isOn),
                Block(
                    width: this.width,
                    height: this.height,
                    isOn: this.widget.isOn),
              ],
            ),
    );
  }
}

class Block extends StatelessWidget {
  final double width;
  final double height;
  final bool isOn;

  const Block({Key key, this.width, this.height, this.isOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: this.width,
        height: this.height,
        decoration: BoxDecoration(
            color: Colors.white.withAlpha(this.isOn ? 255 : 50),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.white
                    .withAlpha(this.isOn ? 255 : 0)
                    .withRed(57).withGreen(255).withBlue(20),
                blurRadius: 2.0,
                spreadRadius: 2.0,
              ),
            ]));
  }
}
