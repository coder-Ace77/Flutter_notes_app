import 'package:flutter/material.dart';
import 'package:todo_notes/pages.dart';

const data = <String>[
  "Hello",
  "world",
  "flutter",
  "dart",
  "android",
  "ios",
  "web",
  "windows",
  "linux",
  "macos",
];

class Books extends StatelessWidget {
  const Books({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.map((e) {
        return GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            alignment: Alignment.center,
            color: const Color.fromARGB(77, 161, 42, 224),
            child: Text(
              e,
              style: const TextStyle(
                fontFamily: "sanserif",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 81, 14, 96),
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
        );
      }).toList(),
    );
  }
}
