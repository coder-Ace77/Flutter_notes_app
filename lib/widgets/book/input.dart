import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Input")),
        body: Column(
          children: [
            SizedBox(
              height: 70,
              child: Container(
                color: Color.fromARGB(255, 78, 134, 158),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          ImagePicker()
                              .pickImage(source: ImageSource.camera)
                              .then((value) =>
                                  {print("Image scouce:${value!.path}")});
                        },
                        child: Icon(Icons.camera_alt, color: Colors.white70)),
                    Icon(Icons.image, color: Colors.white70),
                    Icon(Icons.mic, color: Colors.white70),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 243, 237, 237),
                  ),
                  decoration: const InputDecoration(
                    hintText: "Start typing...",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 243, 237, 237)),
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
          ],
        ),
      ),
    );
  }
}
