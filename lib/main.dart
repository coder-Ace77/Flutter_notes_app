import 'package:flutter/material.dart';
import 'package:todo_notes/books.dart';
import 'package:todo_notes/test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_notes/model.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<List>('books');
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    "TODOxNOTES",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              ListTile(
                title: const Text("Settings"),
                leading: const Icon(Icons.settings),
                iconColor: Colors.blueGrey,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                iconColor: Colors.blueGrey,
                title: const Text("About"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Clear Storage"),
                leading: const Icon(Icons.delete_forever),
                iconColor: Colors.blueGrey,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                var controller = TextEditingController();
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Input"),
                  ),
                  body: Center(
                    child: GestureDetector(
                      child: TextField(
                        controller: controller,
                        autofocus: true,
                        onSubmitted: (value) {
                          print("Value $value");
                          Navigator.pop(context, value);
                        },
                        decoration: const InputDecoration(
                            labelText: "Enter book title"),
                      ),
                      onDoubleTap: () {
                        Navigator.pop(context, controller.text);
                      },
                    ),
                  ),
                );
              }),
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
