import 'package:flutter/material.dart';
import 'package:todo_notes/models/todo.dart';

class TaskWidget extends StatefulWidget {
  Todo todo;
  TaskWidget(this.todo, {super.key});

  @override
  State<TaskWidget> createState() => _TaskWidget();
}

class _TaskWidget extends State<TaskWidget> {
  bool isChecked = false;
  var hoursCompleted = 0;
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
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.watch_later_outlined),
            Text(
              widget.todo.title,
              style: const TextStyle(fontSize: 16),
            ),
            Checkbox(
                shape: const CircleBorder(eccentricity: 0.2),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                    widget.todo.done = isChecked;
                    widget.todo.save();
                  });
                })
          ],
        ),
      ),
    );
  }
}
