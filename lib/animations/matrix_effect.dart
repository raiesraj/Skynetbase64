import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:skynetsecurity/animations/verticaltext.dart';


class MatrixEffect extends StatefulWidget {
  final List todo;
  const MatrixEffect({super.key , required this.todo   });
  @override
  State<StatefulWidget> createState() {
    return _MatrixEffectState();
  }
}

class _MatrixEffectState extends State<MatrixEffect> {


  List<Widget> _verticalLines = [];
  Timer ?timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: _verticalLines

    );

  }

  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _verticalLines.add(
            _getVerticalTextLine(context)
        );
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget _getVerticalTextLine(BuildContext context) {

    Key key = GlobalKey();
    return Positioned(
      key: key,
      left: Random().nextDouble() * MediaQuery.of(context).size.width,
      child: VerticalTextLine(
        text: widget.todo,
          onFinished: () {
            setState(() {
              _verticalLines.removeWhere((element) {
                return element.key == key;
              });
            });
          },
          speed: 1 + Random().nextDouble() * 9,
          maxLength: Random().nextInt(10) + 5,
      ),
    );
  }
}