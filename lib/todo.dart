import 'package:flutter/material.dart';
import 'package:todo_notes/todolist.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Tasks createState() => _Tasks();
}

class _Tasks extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return TodoList();
  }
}
