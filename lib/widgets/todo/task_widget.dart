import 'package:flutter/material.dart';
import 'package:todo_notes/models/todo/todo.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TaskWidget extends StatefulWidget {
  final Todo todo;
  const TaskWidget(this.todo, {super.key});

  @override
  State<TaskWidget> createState() => _TaskWidget();
}

class _TaskWidget extends State<TaskWidget> {
  bool isChecked = false;
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
            Text(
              widget.todo.title,
              style: const TextStyle(fontSize: 16),
            ),
            Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                    widget.todo.done = isChecked;
                    if (widget.todo.repeats == true) {
                      widget.todo.save();
                    } else {
                      widget.todo.delete();
                    }
                  });
                })
          ],
        ),
      ),
    );
  }
}
