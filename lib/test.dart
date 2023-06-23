import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Test createState() => _Test();
}

class _Test extends State {
  List<Widget> wid_list = [ShowBox()];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: wid_list,
        ),
        ElevatedButton(
          onPressed: () {
            print("pressed");
            setState(() {
              wid_list.add(ButtonBox());
            });
          },
          child: const Text("Show Height"),
        ),
      ],
    );
  }
}

class ShowBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(30),
      alignment: Alignment.center,
      color: Color.fromARGB(255, 26, 63, 95),
      child: const Text("Test",
          style: TextStyle(
              fontFamily: "sanserif",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    );
  }
}

class ButtonBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(30),
      alignment: Alignment.center,
      color: Color.fromARGB(255, 26, 63, 95),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              print("pressed");
            },
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () {
              print("pressed");
            },
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () {
              print("pressed");
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
