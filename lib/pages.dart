// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const data = [
  "Hello bros and sis",
  "world",
  "flutter",
  "dart",
  "android",
  "ios",
  "mac",
  "windows",
  "linux",
  "ubuntu",
  "fedora",
  "redhat",
  "centos",
  "kali",
  "parrot",
  "debian",
  "mint",
  "elementary",
  "manjaro",
  "arch",
  "gentoo",
  "slackware",
  "suse",
  "opensuse",
  "sabayon",
  "solus",
  "zorin",
  "raspbian",
  "raspberry pi",
  "arduino",
  "esp32",
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
          }),
    );
  }
}

// ignore: must_be_immutable
class PageItem extends StatelessWidget {
  int index = 0;
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      elevation: elevation.toDouble(),
      child: Container(
        foregroundDecoration: BoxDecoration(
          color:
              _active ? Colors.transparent : Color.fromARGB(255, 118, 237, 6),
          backgroundBlendMode: BlendMode.saturation,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
        // margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        alignment: Alignment.center,
        color: color,
        child: Text(
          "$index ${data[index]}",
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
