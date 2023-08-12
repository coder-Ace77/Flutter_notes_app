import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/todo.dart';

Box getTodoBox() => Hive.box<Todo>('todos');

void addTodos(x) {
  final box = getTodoBox();
  box.add(x);
}

void deleteTodos(x) {
  final box = getTodoBox();
  box.delete(x);
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
