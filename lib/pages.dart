import 'package:flutter/material.dart';

const data = [
  "Hello bros and sis",
  "world",
  "flutter",
  "dart",
  "android",
];

var active = const Color.fromARGB(77, 161, 42, 224);

class Pages extends StatefulWidget {
  final String title = "X";
  const Pages({Key? key, String? title}) : super(key: key);
  // var k = GlobalKey();
  @override
  // ignore: library_private_types_in_public_api
  _Pages createState() => _Pages();
}

class _Pages extends State<Pages> {
  final _pagenumber = 0;
  final controller = ScrollController();
  List<Key> keys = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagenumber.toString()),
      ),
      body: GestureDetector(
        child: ListView(
          controller: controller,
          children: data.asMap().entries.map((e) {
            if (_pagenumber == e.key) {
              active = Colors.red;
            } else {
              active = const Color.fromARGB(255, 218, 193, 238);
            }
            final k = GlobalKey();
            keys.add(k);
            return Container(
              key: k,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              alignment: Alignment.center,
              color: active,
              child: Text(
                "${e.value} ${e.key}",
                style: const TextStyle(
                  fontFamily: "sanserif",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 81, 14, 96),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
