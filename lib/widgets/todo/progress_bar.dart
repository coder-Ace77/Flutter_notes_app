import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo_notes/models/todo/todo.dart';

class ProgressBar extends StatefulWidget {
  Todo todo;
  ProgressBar(this.todo, {super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
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
              );
            });
      },
      child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          // height: 80,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                        percent: (widget.todo.progress /
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
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.todo.progress != widget.todo.totalUnits) {
                        widget.todo.progress = widget.todo.progress + 1;
                        widget.todo.save();
                      }
                      if (widget.todo.progress == widget.todo.totalUnits) {
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
