import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo_notes/helpers/todo/model_todo.dart';
import '../../models/todo/todo.dart';
import './percentage.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProgressBar extends StatefulWidget {
  final Todo todo;
  const ProgressBar(this.todo, {super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool isChecked = false;
  DateTime currTime = DateTime.now();
  int elapsed = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (_) {
              return Animate(
                effects: [FadeEffect(duration: 50.ms)],
                child: AlertDialog(
                  title: const Text("Are you sure to delete?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          widget.todo.delete();
                          Navigator.pop(context);
                        },
                        child: const Text("Yes")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No")),
                  ],
                ),
              );
            });
      },
      onTap: () {
        currTime = DateTime.now();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) =>
                    PercentageIndicator(task: widget.todo))).then(
          (value) {
            elapsed = DateTime.now().minute - currTime.minute;
            widget.todo.progress = widget.todo.progress! + elapsed / 60;
            widget.todo.save();
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
                list[i].progress = list[i].progress! + elapsed / 60;
                list[i].save();
                break;
              }
            }
          },
        );
      },
      child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(top: 10),
          // height: 80,
          decoration: const BoxDecoration(
            color: Color.fromARGB(200, 208, 222, 237),
          ),
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
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      LinearPercentIndicator(
                        barRadius: const Radius.circular(10),
                        width: 200.0,
                        lineHeight: 10.0,
                        percent: (widget.todo.progress! /
                                    widget.todo.totalUnits!.toDouble()) <=
                                1
                            ? widget.todo.progress! /
                                widget.todo.totalUnits!.toDouble()
                            : 1,
                        backgroundColor: Colors.grey,
                        progressColor: const Color.fromARGB(255, 83, 137, 128),
                      ),
                      Text(
                          "${widget.todo.progress!.toInt().toString()}/${widget.todo.totalUnits.toString()}"),
                    ],
                  ),
                ],
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.todo.progress = widget.todo.progress! + 1;
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
                      bool flag = false;
                      for (var i = 0; i < list.length; i++) {
                        if (list[i].title == days[today - 1] &&
                            widget.todo.title != days[today - 1]) {
                          list[i].progress = list[i].progress! + 1;
                          list[i].save();
                          break;
                        }
                      }
                      widget.todo.save();
                      if (widget.todo.progress! >= widget.todo.totalUnits!) {
                        widget.todo.done = true;
                        widget.todo.save();
                      }
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              )
            ],
          )),
    );
  }
}
