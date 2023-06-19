// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:todo_notes/input.dart';

List data = <String>[
  "Use double tap to add notes page items",
];

class Pages extends StatefulWidget {
  const Pages({Key? key, String? title}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _Pages createState() => _Pages();
}

class _Pages extends State<Pages> {
  int _pagenumber = 0;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagenumber.toString()),
      ),
      body: GestureDetector(
        child: ScrollablePositionedList.builder(
          itemCount: data.length,
          itemScrollController: itemScrollController,
          scrollOffsetController: scrollOffsetController,
          itemBuilder: (context, index) {
            return PageItem(index, index == _pagenumber);
          },
        ),
        onTap: () {
          setState(() {});
          if (_pagenumber >= data.length - 1) {
            return;
          }
          _pagenumber++;
          itemScrollController
              .scrollTo(
                index: _pagenumber,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
                alignment: 0.08,
              )
              .then((x) {});
        },
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Input();
              },
            ),
          ).then((value) {
            setState(() {
              data.add(value);
            });
          });
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class PageItem extends StatelessWidget {
  int index = 0;
  // ignore: prefer_final_fields
  bool _active = false;
  Color color = Colors.grey;
  int elevation = 0;
  PageItem(this.index, this._active, {super.key}) {
    if (_active) {
      color = Colors.blue;
      elevation = 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    double verticalHeight = 25;
    if (data[index].length < 50) {
      verticalHeight = 50;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      elevation: elevation.toDouble(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalHeight),
        alignment: Alignment.center,
        color: color,
        child: Text(
          "${data[index]}",
          style: const TextStyle(
            fontFamily: "sanserif",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 245, 242, 246),
          ),
        ),
      ),
    );
  }
}
