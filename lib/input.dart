import 'package:flutter/material.dart';
import 'package:custom_floating_action_button/custom_floating_action_button.dart';

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  final TextEditingController _controller = TextEditingController();
  final double space = 100;
  @override
  Widget build(BuildContext context) {
    return CustomFloatingActionButton(
      body: Scaffold(
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
      ),
      options: const [
        CircleAvatar(
          child: Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
        CircleAvatar(
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ),
        CircleAvatar(
          child: Icon(
            Icons.photo_album,
            color: Colors.white,
          ),
        ),
      ],
      type: CustomFloatingActionButtonType.verticalUp,
      openFloatingActionButton: const Icon(Icons.add, color: Colors.white),
      closeFloatingActionButton: const Icon(Icons.close, color: Colors.white),
      floatinButtonColor: Colors.blueGrey,
      spaceFromBottom: space,
    );
  }
}
