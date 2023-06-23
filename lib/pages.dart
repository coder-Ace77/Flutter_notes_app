// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:todo_notes/input.dart';
import 'package:todo_notes/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Pages extends StatefulWidget {
  String? title = "X";
  Pages({Key? key, this.title});
  @override
  // ignore: library_private_types_in_public_api
  _Pages createState() => _Pages();
}

class _Pages extends State<Pages> {
  int _pagenumber = 0;
  final ItemScrollController itemScrollController = ItemScrollController();
  int pagesLength = 0;
  bool state = false;
  void _scrollDown() {
    setState(() {});
    if (_pagenumber >= pagesLength - 1) return;
    _pagenumber++;
    itemScrollController.scrollTo(
      index: _pagenumber,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.08,
    );
  }

  void _scrollUp() {
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
  }

  Widget _floatingActionButton(BuildContext context) => FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Input();
              },
            ),
          ).then((value) {
            if (value != null) {
              addPage(widget.title, value);
            }
          });
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      floatingActionButton: _floatingActionButton(context),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<List>('books').listenable(),
        builder: (context, box, _) {
          final page = box.get(widget.title);
          if (page != null) pagesLength = page.length;
          return GestureDetector(
            onTap: _scrollDown,
            onDoubleTap: _scrollUp,
            onLongPress: () {
              setState(() {
                state = !state;
              });
            },
            child: ScrollablePositionedList.builder(
              itemCount: page!.length,
              itemScrollController: itemScrollController,
              itemBuilder: (context, index) {
                return PageItem(page, index, index == _pagenumber, state);
              },
            ),
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
  Color color = Color(0xFF536D7A);
  int elevation = 0;
  List page = [];
  bool _state = false;

  List<Widget> widgetList = [];

  PageItem(this.page, this.index, this._active, this._state, {super.key}) {
    if (_active) {
      color = const Color.fromARGB(255, 55, 87, 102);
      elevation = 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    double verticalHeight = 25;
    if (page[index].length < 50) {
      verticalHeight = 40;
    }
    widgetList.add(Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      elevation: elevation.toDouble(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalHeight),
        alignment: Alignment.topLeft,
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
    ));
    if (_state) {
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.delete),
          Icon(Icons.edit),
          Icon(Icons.share),
        ],
      ));
    }
    return Stack(
      alignment: Alignment.center,
      children: widgetList,
    );
  }
}
