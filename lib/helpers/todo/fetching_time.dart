import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model_todo.dart';
import '../../models/todo/todo.dart';

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
  int currentWeekDay = currentDateTime.weekday;

  int previousDay = previousDateTime.day;
  int previousMonth = previousDateTime.month;
  int previousWeekDay = previousDateTime.weekday;

  if (currentDay != previousDay || currentMonth != previousMonth) {
    for (Todo i in l) {
      if (i.repeatState == 1) {
        i.done = false;
        i.progress = 0;
        i.save();
      }
    }
  }
  if ((currentWeekDay == 1 && currentWeekDay != previousWeekDay)) {
    for (Todo i in l) {
      if (i.repeatState == 2) {
        i.done = false;
        i.progress = 0;
        i.save();
      }
    }
  }
  if (currentMonth != previousMonth) {
    for (Todo i in l) {
      if (i.repeatState == 3) {
        i.done = false;
        i.progress = 0;
        i.save();
      }
    }
  }
  Box timeBox = getTimeBox();
  timeBox.put('time', currentDateTime);
}
