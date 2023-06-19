// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:todo_notes/input.dart';
import 'package:todo_notes/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

// List data = <String>[
//   "Use double tap to add notes page items",
// ];

class Pages extends StatefulWidget {
  String? title = "X";
  Pages({Key? key, String? title}) : super(key: key) {
    this.title = title;
  }
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
        title: Text(widget.title!),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<List>('title').listenable(),
        builder: (context, box, _) {
          final page = box.get(widget.title);
          return GestureDetector(
            child: ScrollablePositionedList.builder(
              itemCount: page!.length,
              itemScrollController: itemScrollController,
              scrollOffsetController: scrollOffsetController,
              itemBuilder: (context, index) {
                return PageItem(page, index, index == _pagenumber);
              },
            ),
            onTap: () {
              setState(() {});
              if (_pagenumber >= page.length - 1) {
                return;
              }
              _pagenumber++;
              itemScrollController.scrollTo(
                index: _pagenumber,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
                alignment: 0.08,
              );
            },
            onDoubleTap: () {
              setState(() {});
              if (_pagenumber <= 0) {
                return;
              }
              _pagenumber--;
              itemScrollController.scrollTo(
                index: _pagenumber,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
                alignment: 0.08,
              );
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
                print(value);
                if (value != null) {
                  addPage(widget.title, value);
                }
                printAll();
              });
            },
          );
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
  Color color = Colors.blueGrey.shade500;
  int elevation = 0;
  List page = [];
  PageItem(this.page, this.index, this._active, {super.key}) {
    if (_active) {
      color = Color.fromARGB(255, 55, 87, 102);
      elevation = 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    double verticalHeight = 25;
    if (page[index].length < 50) {
      verticalHeight = 50;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      elevation: elevation.toDouble(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalHeight),
        alignment: Alignment.center,
        color: color,
        child: Text(
          "${page[index]}",
          style: const TextStyle(
            fontFamily: "sanserif",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 236, 227, 240),
          ),
        ),
      ),
    );
  }
}
