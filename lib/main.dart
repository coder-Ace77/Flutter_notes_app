import 'package:flutter/material.dart';
import 'package:todo_notes/books.dart';
import 'package:todo_notes/test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:todo_notes/model.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<List>('title');
  addBook("title", ["First book"]);
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
        primarySwatch: Colors.blueGrey,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text("Input"),
                  ),
                  body: Center(
                    child: TextField(
                      autofocus: true,
                      onSubmitted: (value) {
                        print("Value $value");
                        Navigator.pop(context, value);
                      },
                      decoration:
                          InputDecoration(labelText: "Enter book title"),
                    ),
                  ),
                ),
              ),
            ).then((value) {
              setState(() {
                editBook("title", value);
                addBook(value, ["First page"]);
              });
              printAll();
            });
          },
          child: const Icon(Icons.add),
        ),
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
                  color: Colors.blueGrey,
                )),
                Tab(
                    icon: Icon(
                  Icons.check_box,
                  color: Colors.blueGrey,
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

// void addBook(x) {
//   final books = Hive.box<List>('books');
//   books.put('New Book', x);
// }
