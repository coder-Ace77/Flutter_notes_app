import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './model_todo.dart';
import "./models/todo.dart";

Box getTimeBox() {
  return Hive.box<DateTime>("DateTime");
}

DateTime getLastUpdate() {
  Box box = getTimeBox();
  if (box.get('time') == null) {
    box.put('time', DateTime.now());
    Box todoBox = getTodoBox();
    List l = todoBox.values.toList().cast<Todo>();
    for (Todo i in l) {
      i.done = false;
      i.save();
    }
  }
  return box.get('time');
}

void daliyComp() {
  Box todoBox = getTodoBox();
  List l = todoBox.values.toList().cast<Todo>();

  DateTime currentDateTime = DateTime.now();
  DateTime previousDateTime = getLastUpdate();

  int currentDay = currentDateTime.day;
  int currentMonth = currentDateTime.month;

  int previousDay = previousDateTime.day;
  int previousMonth = previousDateTime.month;

  if (currentDay > previousDay) {
    previousDay = currentDay;
    for (Todo i in l) {
      if (i.repeatState == "Daily") {
        i.done = false;
        i.progress = 0;
        i.save();
      }
    }
  }
}
