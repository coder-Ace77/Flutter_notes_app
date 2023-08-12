import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key});

  @override
  State<TaskWidget> createState() => _TaskWidget();
}

class _TaskWidget extends State<TaskWidget> {
  bool isChecked = false;
  var hoursCompleted = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.watch_later_outlined),
          Text(
            "Learn Artificial Intelligence",
            style: TextStyle(fontSize: 16),
          ),
          Checkbox(
              shape: CircleBorder(eccentricity: 0.2),
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              })
        ],
      ),
    );
  }
}
