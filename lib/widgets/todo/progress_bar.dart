import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../models/todo/todo.dart';
import './percentage.dart';

class ProgressBar extends StatefulWidget {
  Todo todo;
  ProgressBar(this.todo, {super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool isChecked = false;
  var hoursCompleted = 0;
  DateTime curr_time = DateTime.now();
  int elapsed = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print("Editing!!!");
      },
      onTap: () {
        curr_time = DateTime.now();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) =>
                    PercentageIndicator(task: widget.todo.title))).then(
          (value) {
            elapsed = DateTime.now().minute - curr_time.minute;
            print("elapsed $elapsed");
            widget.todo.progress = widget.todo.progress! + elapsed / 60;
            print("${widget.todo.progress}");
            widget.todo.save();
          },
        );
      },
      child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          // height: 80,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.todo.title,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      LinearPercentIndicator(
                        barRadius: Radius.circular(10),
                        width: 200.0,
                        lineHeight: 10.0,
                        percent: (widget.todo.progress! /
                            widget.todo.totalUnits!.toDouble()),
                        backgroundColor: Colors.grey,
                        progressColor: Colors.greenAccent,
                      ),
                      Text(
                          "${widget.todo.progress!.toInt().toString()}/${widget.todo.totalUnits.toString()}"),
                    ],
                  ),
                ],
              ),
              Center(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.todo.progress != widget.todo.totalUnits) {
                        widget.todo.progress = widget.todo.progress! + 1;
                        print(widget.todo.progress);
                        widget.todo.save();
                      }
                      if (hoursCompleted == widget.todo.totalUnits) {
                        print("Done!!!!");
                        widget.todo.done = true;
                        widget.todo.save();
                      }
                    });
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          )),
    );
  }
}
