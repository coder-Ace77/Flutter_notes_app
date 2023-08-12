import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_notes/model.dart';
import 'models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);
  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Todo>('todos').listenable(),
        builder: (context, box, _) {
          List list = box.values.toList().cast<Todo>();
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
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                if (index == list.length - 1) {
                  return Column(
                    children: [
                      ListItemButton(false),
                    ],
                  );
                }
                return ListItems(list[index].title);
              });
        });
  }
}

// ignore: must_be_immutable
class ListItems extends StatefulWidget {
  String title = "";
  ListItems(this.title, {Key? key}) : super(key: key);
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
                // removeTodos(widget.title);
                setState(() {
                  value = x;
                });
              }),
          Text(widget.title,
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
  final TextEditingController mycontroller = TextEditingController();
  bool _value = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add new task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: mycontroller,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Enter task",
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _value,
                            onChanged: (x) {
                              setState(() {
                                print("setstate runs $x $_value");
                                if (x != null) {
                                  _value = x;
                                } else {
                                  _value = false;
                                }
                              });
                            }),
                        const Text("Daily"),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (widget.isBook) {
                          editBook("title", mycontroller.text);
                        } else {
                          // addTodos();
                        }
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text("Add"))
                ],
              );
            });
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
