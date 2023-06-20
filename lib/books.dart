import 'package:flutter/material.dart';
import 'package:todo_notes/pages.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_notes/model.dart';

class Books extends StatelessWidget {
  const Books({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<List>('books').listenable(),
        builder: (context, box, _) {
          final books = box.get("title");
          if (books == null || books.isEmpty) {
            return const Center(
              child: Text("No Books"),
            );
          }
          return ListView(
              children: books.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pages(title: entry.value.toString()),
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
                            print(entry.key);
                            deletebook(entry.key);
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 75, 104, 118),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  entry.value.toString(),
                  style: const TextStyle(
                    fontFamily: "sanserif",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 234, 230, 230),
                  ),
                ),
              ),
            );
          }).toList());
        });
  }
}
