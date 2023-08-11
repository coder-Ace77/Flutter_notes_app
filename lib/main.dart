import 'package:flutter/material.dart';
import 'package:todo_notes/books.dart';
import 'package:todo_notes/model_todo.dart';
import 'package:todo_notes/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_notes/model.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<List>('books');
  await Hive.openBox<List>('todo');
  await Hive.openBox<int>('day');
  checktime();
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this, initialIndex: 0);

  @override
  void initState() {
    super.initState();
    _tabController.addListener(() {});
  }

  void addbookpage() {
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
                  // print("Value $value");
                  Navigator.pop(context, value);
                },
                decoration:
                    const InputDecoration(labelText: "Enter book title"),
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
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const NewDrawer(),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Column(
          children: [
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
                Tasks(),
              ]),
            )
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class NewDrawer extends StatelessWidget {
  const NewDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                "TODOxNOTES",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
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
    );
  }
}
