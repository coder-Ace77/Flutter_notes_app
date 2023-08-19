import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class PercentageIndicator extends StatefulWidget {
  String task;
  PercentageIndicator({required this.task, super.key});

  @override
  State<PercentageIndicator> createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
  CountDownController _controller = CountDownController();
  bool _isPause = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: CircularCountDownTimer(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              duration: 3600,
              fillColor: Colors.green,
              ringColor: Colors.amber,
              isReverseAnimation: true,
              // color: Colors.white,
              controller: _controller,
              backgroundColor: Colors.white54,
              strokeWidth: 10.0,
              strokeCap: StrokeCap.round,
              isTimerTextShown: true,
              isReverse: true,
              onComplete: () {
                print("Completed");
              },
              textStyle: TextStyle(fontSize: 50.0, color: Colors.black),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_isPause) {
                    _isPause = false;
                    _controller.resume();
                  } else {
                    _isPause = true;
                    _controller.pause();
                  }
                });
              },
              child: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    Icon(
                      _isPause ? Icons.pause : Icons.play_arrow,
                    ),
                    Text(_isPause ? "Resume" : "pause"),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
