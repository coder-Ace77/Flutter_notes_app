import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Test createState() => _Test();
}

class _Test extends State {
  final key = GlobalKey();

  void showHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          key: key,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(30),
          alignment: Alignment.center,
          color: Colors.purple,
          child: const Text("Test",
              style: TextStyle(
                  fontFamily: "sanserif",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: showHeight,
          child: const Text("Show Height"),
        ),
      ],
    );
  }
}
