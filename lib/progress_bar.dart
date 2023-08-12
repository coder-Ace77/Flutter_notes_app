import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo_notes/models/todo.dart';

class ProgressBar extends StatefulWidget {
  Todo todo;
  ProgressBar(this.todo, {super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool isChecked = false;
  var hoursCompleted = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print("Editing!!!");
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
                        percent: (hoursCompleted /
                            widget.todo.totalUnits!.toDouble()),
                        backgroundColor: Colors.grey,
                        progressColor: Colors.greenAccent,
                      ),
                      Text(
                          "${widget.todo.progress.toString()}/${widget.todo.totalUnits.toString()}"),
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
                      if (hoursCompleted != widget.todo.totalUnits) {
                        hoursCompleted = hoursCompleted + 1;
                        widget.todo.progress = hoursCompleted;
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
