import 'package:flutter/material.dart';
import 'package:todo_notes/books.dart';
import 'package:todo_notes/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: "TODOxNOTES"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: const [
            TabBar(
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.book,
                  color: Colors.purple,
                )),
                Tab(
                    icon: Icon(
                  Icons.check_box,
                  color: Colors.purple,
                )),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                Books(),
                Test(),
              ]),
            )
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
