import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box getTodoBox() => Hive.box<List>('todo');

List<dynamic> getTodos() {
  final box = getTodoBox();
  print("HELLO");
  var x = box.get("todos");
  if (x == null) {
    return [];
  }
  return x;
}

List<dynamic> getDailyTodos() {
  final box = getTodoBox();
  var x = box.get("dailytodos");
  if (x == null) {
    return [];
  }
  return x;
}

void addDailyTasks() {
  final box = getTodoBox();
  List dailylist = getDailyTodos();
  box.put("todos", dailylist);
}

void addTodos(x) {
  if (x == null) return;
  final box = getTodoBox();
  List l = getTodos();
  l.add(x);
  box.put("todos", l);
}

void addDailyTodos(x) {
  if (x == null) return;
  final box = getTodoBox();
  List l = getDailyTodos();
  l.add(x);
  box.put("dailytodos", l);
}

void checktime() {
  Box box = Hive.box<int>('day');
  int? x = box.get("day");
  if (x == null) {
    box.put("day", DateTime.now().day);
    return;
  } else {
    if (x != DateTime.now().day) {
      box.put("day", DateTime.now().day);
      addDailyTasks();
    }
  }
}

void printAllDaily() {
  List l = getDailyTodos();
  for (var i in l) {}
}

void removeTodos(x) {
  if (x == null) return;
  final box = getTodoBox();
  List l = getTodos();
  l.remove(x);
  box.put("todos", l);
}
