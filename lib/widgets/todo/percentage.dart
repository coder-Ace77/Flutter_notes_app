import 'package:flutter/material.dart';
import '../../models/todo/todo.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:todo_notes/helpers/todo/model_todo.dart';

class PercentageIndicator extends StatefulWidget {
  final Todo task;
  const PercentageIndicator({required this.task, super.key});

  @override
  State<PercentageIndicator> createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
  final CountDownController _controller = CountDownController();
  bool _isPause = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
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
              controller: _controller,
              backgroundColor: Color.fromARGB(137, 215, 208, 208),
              strokeWidth: 10.0,
              strokeCap: StrokeCap.round,
              isTimerTextShown: true,
              isReverse: true,
              onComplete: () {
                widget.task.progress = widget.task.progress! + 1;
                widget.task.save();
                final today = DateTime.now().weekday;
                var list = getTodoList();
                List days = [
                  "Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday",
                  "Saturday",
                  "Sunday"
                ];
                for (var i = 0; i < list.length; i++) {
                  if (list[i].title == days[today - 1]) {
                    list[i].progress = list[i].progress! + 1;
                    list[i].save();
                    break;
                  }
                }
                Navigator.pop(context);
              },
              textStyle: const TextStyle(fontSize: 50.0, color: Colors.black),
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
                width: 70,
                child: Row(
                  children: [
                    Icon(
                      _isPause ? Icons.play_arrow : Icons.pause,
                    ),
                    Text(_isPause ? " Resume" : " Pause"),
                  ],
                ),
              )),
          Text("Repeats : ${widget.task.repeats.toString()}"),
          Text("Progress : ${widget.task.progress.toString()}"),
          Text("Total Units : ${widget.task.totalUnits.toString()}"),
          Text("Done : ${widget.task.done.toString()}"),
          Text("Repeat State : ${widget.task.repeatState.toString()}")
        ],
      ),
    );
  }
}
