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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your notes',
              fillColor: Color.fromARGB(255, 48, 44, 44),
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
