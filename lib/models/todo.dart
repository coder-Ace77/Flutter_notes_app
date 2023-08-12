import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String title;
  @HiveField(1)
  bool isGoal;
  @HiveField(2)
  int progress;
  @HiveField(3)
  bool done;
  @HiveField(4)
  bool repeats;
  @HiveField(5)
  int repeatState;
  Todo({
    required this.title,
    required this.done,
    required this.isGoal,
    required this.progress,
    required this.repeats,
    required this.repeatState,
  });
}
