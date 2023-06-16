import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _Test createState() => _Test();
}

class _Test extends State {
  final key = GlobalKey();

  void showHeight() {
    print("A: ${key.currentContext}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Inside calc");
      final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
      print(box.size);
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
