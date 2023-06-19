import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// class Boxes {
//   static Box<List> getBooks() => Hive.box<List>('books');
// }

void addBook(title, x) {
  final books = Hive.box<List>('title');
  books.put(title, x);
}

List<dynamic>? getBooks({title: "title"}) {
  final books = Hive.box<List>('title');
  return books.get(title);
}

void editBook(title, x) {
  final books = Hive.box<List>('title');
  var l = getBooks(title: title);
  l!.add(x);
  addBook(title, l);
}

void addPage(title, x) {
  editBook(title, x);
}

void printAll() {
  final keys = getBooks(title: "title");
  print("Keys $keys");

  for (var i = 0; i < keys!.length; i++) {
    final book = getBooks(title: keys[i]);
    print("Book $book");
  }
}

void deletebook(title) {
  // final books = Hive.box<List>('title');
  var l = getBooks(title: "title");
  l!.remove(title);
  addBook("title", l);
}
