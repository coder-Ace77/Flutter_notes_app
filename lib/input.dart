import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input")),
      body: Center(
        child: GestureDetector(
          child: TextField(
            controller: _controller,
            style: const TextStyle(
              color: Color.fromARGB(255, 243, 237, 237),
            ),
            decoration: const InputDecoration(
              hintText: "Start typing...",
              hintStyle: TextStyle(color: Color.fromARGB(255, 243, 237, 237)),
              filled: true,
              fillColor: Color.fromARGB(255, 71, 99, 111),
            ),
            maxLines: 20,
            autofocus: true,
          ),
          onDoubleTap: () {
            Navigator.pop(context, _controller.text);
          },
        ),
      ),
    );
  }
}
