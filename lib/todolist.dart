import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_notes/add_task.dart';
import 'package:todo_notes/model.dart';
import 'package:todo_notes/model_todo.dart';
import 'models/todo.dart';
import 'progress_bar.dart';
import 'task_widget.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);
  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Todo>('task').listenable(),
        builder: (context, box, _) {
          List list = box.values.toList().cast<Todo>();
          List temp = [];
          for (Todo i in list) {
            if (i.done == false) {
              temp.add(i);
            }
          }
          list = temp;
          if (list.isEmpty) {
            return Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ListItemButton(false),
                  Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: const Text("No tasks yet")),
                ],
              ),
            );
          }
          print(temp);
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                if (index == list.length - 1) {
                  if (list[index].isGoal) {
                    return Column(
                      children: [
                        ProgressBar(list[index]),
                        ListItemButton(false),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      TaskWidget(list[index]),
                      ListItemButton(false),
                    ],
                  );
                }
                if (list[index].isGoal) {
                  return ProgressBar(list[index]);
                }
                return TaskWidget(list[index]);
              });
        });
  }
}

// ignore: must_be_immutable
class ListItems extends StatefulWidget {
  Todo todo;
  ListItems(this.todo, {Key? key}) : super(key: key);
  @override
  ListItemsState createState() => ListItemsState();
}

class ListItemsState extends State<ListItems> {
  bool? value = false;
  String item = "Buy milk";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 208, 222, 237),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Row(
        children: [
          Checkbox(
              value: value,
              onChanged: (x) {
                widget.todo.done = true;
                setState(() {
                  printTodo();
                  value = x;
                });
              }),
          Text(widget.todo.title,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 21, 77, 97))),
        ],
      ),
    );
  }
}

class ListItemButton extends StatefulWidget {
  bool isBook = false;
  ListItemButton(this.isBook, {Key? key}) : super(key: key);
  @override
  ListItemsStateButton createState() => ListItemsStateButton();
}

class ListItemsStateButton extends State<ListItemButton> {
  void check_task(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddTask())).then(
      (value) {
        addTodos(value);
      },
    );
  }

  final TextEditingController mycontroller = TextEditingController();
  bool _value = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        check_task(context);
      },
      child: Container(
        padding: const EdgeInsets.all(23),
        child: Row(
          children: const [
            Icon(Icons.add, color: Color.fromARGB(255, 21, 77, 97)),
            Text("  Add new task",
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 65, 104, 119))),
          ],
        ),
      ),
    );
  }
}
