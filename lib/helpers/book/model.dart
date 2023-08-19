import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void addBook(title, x) {
  final books = Hive.box<List>('books');
  books.put(title, x);
}

List<dynamic>? getBooks({title: "title"}) {
  final books = Hive.box<List>('books');
  return books.get(title);
}

Box getBox() => Hive.box<List>('books');

void editBook(title, x) {
  List? l = getBooks(title: title);
  if (x == null) {
    return;
  }
  if (l == null) {
    l = [x];
  } else {
    l.add(x);
  }
  addBook(title, l);
}

void addPage(title, x) {
  editBook(title, x);
}

void printAll() {
  final keys = getBooks(title: "title");
  print("Books list $keys");
  if (keys == null || keys.isEmpty) {
    print("No books");
    return;
  }
  for (var i = 0; i < keys.length; i++) {
    final book = getBooks(title: keys[i]);
    print("Book $book");
  }
}

void deletebook(bookindex) {
  var l = getBooks(title: "title");
  if (l == null) {
    return;
  }
  final booktitle = l[bookindex];
  l.remove(booktitle);
  addBook("title", l);
  getBox().delete(booktitle);
}
