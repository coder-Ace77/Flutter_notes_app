import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/todo/todo.dart';

Box getTodoBox() => Hive.box<Todo>('tasks');

void addTodos(x) {
  final box = getTodoBox();
  if (x.title == null) {
    print("Title is null");
    return;
  }
  box.add(x);
  print("Task added");
  printTodo();
}

void deleteTodos(x) {
  final box = getTodoBox();
  print(x);
}

void editTodos(x, title, isGoal, progress, done, repeats, repeatState) {
  x.title = title;
  x.isGoal = isGoal;
  x.progress = progress;
  x.done = done;
  x.repeats = repeats;
  x.repeatState = repeatState;
  x.save();
}

void printTodo() {
  final box = getTodoBox();
  print(box.values.toList().cast<Todo>());
}
