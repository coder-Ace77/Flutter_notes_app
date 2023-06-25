import 'package:flutter/material.dart';
import 'package:todo_notes/pages.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_notes/model.dart';
import 'package:todo_notes/todolist.dart';

class Books extends StatelessWidget {
  const Books({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<List>('books').listenable(),
        builder: (context, box, _) {
          var books = box.get("title");
          if (books == null) {
            books = [];
          }
          if (books.isEmpty) {
            return Column(
              children: [
                ListItemButton(true),
                Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Text("No Books")),
              ],
            );
          }
          return ListView.builder(
              itemCount: books.length + 1,
              itemBuilder: (context, index) {
                if (books!.length == index) {
                  return GestureDetector(child: ListItemButton(true));
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pages(title: books![index]),
                      ),
                    );
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete Book"),
                          content: const Text("Are you sure?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                print(index);
                                deletebook(index);
                                Navigator.pop(context);
                                printAll();
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    color: const Color.fromARGB(255, 208, 222, 237),
                    padding: const EdgeInsets.all(30),
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      books[index],
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 21, 77, 97)),
                    ),
                  ),
                );
              });
        });
  }
}
