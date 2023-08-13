import 'package:flutter/material.dart';
import 'progress_bar.dart';
import 'task_widget.dart';
import 'package:todo_notes/models/todo/todo.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleController = TextEditingController();

  var currentText = "No Repeat";
  var _currentSliderValue = 0.0;

  int red = 0;
  int green = 255;
  int blue = 0;

  bool isGoal = false;
  int chooseColor1 = 255;
  int chooseColor2 = 0;

  void setGoal(bool value) {
    setState(() {
      isGoal = value;
      if (isGoal) {
        chooseColor2 = 255;
        chooseColor1 = 0;
      } else {
        chooseColor1 = 255;
        chooseColor2 = 0;
      }
    });
  }

  void setText(String t1) {
    setState(() {
      currentText = t1;
    });
  }

  void setCurrentSliderValue(double value) {
    setState(() {
      _currentSliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add task"),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                        hintText: 'Enter the title')),
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  title: const Text("No Repeat"),
                  leading: Radio(
                    value: "No Repeat",
                    groupValue: currentText,
                    onChanged: (value) {
                      setText(value.toString());
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  title: const Text("Daily"),
                  leading: Radio(
                    value: "Daily",
                    groupValue: currentText,
                    onChanged: (value) {
                      setText(value.toString());
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  title: const Text("Weekly"),
                  leading: Radio(
                    value: "Weekly",
                    groupValue: currentText,
                    onChanged: (value) {
                      setText(value.toString());
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListTile(
                  title: const Text("Monthly"),
                  leading: Radio(
                    value: "Monthly",
                    groupValue: currentText,
                    onChanged: (value) {
                      setText(value.toString());
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Task",
                    style: TextStyle(
                        color: Color.fromRGBO(0, chooseColor1, 0, 0.8),
                        fontSize: 18),
                  ),
                  Switch(
                      value: isGoal,
                      onChanged: (value) {
                        setGoal(value);
                      }),
                  Text(
                    "Goal",
                    style: TextStyle(
                        color: Color.fromRGBO(0, chooseColor2, 0, 0.8),
                        fontSize: 18),
                  )
                ],
              ),
              Slider(
                  value: _currentSliderValue,
                  max: 20,
                  divisions: 20,
                  onChanged: (value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  }),
              Text(_currentSliderValue.toInt().toString() + " units"),
              ElevatedButton(
                  onPressed: () {
                    int s = 0;
                    if (currentText == "Daily") {
                      s = 1;
                    } else if (currentText == "Weekly") {
                      s = 2;
                    } else if (currentText == "Monthly") {
                      s = 3;
                    }
                    Navigator.pop(
                        context,
                        Todo(
                            title: titleController.text,
                            totalUnits: _currentSliderValue.toInt(),
                            isGoal: isGoal,
                            done: false,
                            progress: 0,
                            repeats: s == 0 ? false : true,
                            repeatState: s));
                  },
                  child: const Text("Save")),
            ],
          ),
        ));
  }
}
