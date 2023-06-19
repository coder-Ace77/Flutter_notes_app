import 'package:flutter/material.dart';
import 'package:todo_notes/pages.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:todo_notes/model.dart';

class Books extends StatelessWidget {
  const Books({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final books = getBooks(title: "title");
    // print("Books $books");

    return ValueListenableBuilder(
        valueListenable: Hive.box<List>('title').listenable(),
        builder: (context, box, _) {
          final books = box.get("title");
          return ListView(
            children: books!.map((e) {
              return GestureDetector(
                onDoubleTap: () {
                  print("Details $e");
                  print("Trying delete");
                  deletebook(e);
                  printAll();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  alignment: Alignment.center,
                  color: Colors.blueGrey.shade500,
                  child: Text(
                    e,
                    style: const TextStyle(
                      fontFamily: "sanserif",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 230, 230),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pages(title: e),
                    ),
                  );
                },
                onVerticalDragDown: (d) {
                  print("Vertical Drag Down");
                  ScrollController().animateTo(0.0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn);
                },
              );
            }).toList(),
          );
        });
  }
}
