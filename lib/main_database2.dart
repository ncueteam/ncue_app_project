// import 'dart:async';
//
// import 'package:sqflite/sqflite.dart';
//
// void main() async {
//   final database = openDatabase(
//     '${await getDatabasesPath()}book_database.db',
//     onCreate: (db, version) {
//       return db.execute(
//         "CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT, price INTEGER)",
//       );
//     },
//     version: 1,
//   );
//
//   Future<void> insertBook(Book book) async {
//     // Get a reference to the database.
//     final Database db = await database;
//
//     await db.insert(
//       'books',
//       book.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<List<Book>> books() async {
//     final Database db = await database;
//
//     final List<Map<String, dynamic>> maps = await db.query('books');
//
//     return List.generate(maps.length, (i) {
//       return Book(
//         id: maps[i]['id'],
//         title: maps[i]['title'],
//         price: maps[i]['price'],
//       );
//     });
//   }
//
//   Future<void> updateBook(Book book) async {
//     final db = await database;
//     await db.update(
//       'books',
//       book.toMap(),
//       where: "id = ?",
//       whereArgs: [book.id],
//     );
//   }
//
//   Future<void> deleteBook(int id) async {
//     final db = await database;
//     await db.delete(
//       'books',
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }
//
//   var b1 = Book(
//     id: 0,
//     title: 'Let Us C',
//     price: 300,
//   );
//
//   await insertBook(b1);
//
//   print(await books());
//
//   b1 = Book(
//     id: b1.id,
//     title: b1.title,
//     price: b1.price,
//   );
//   await updateBook(b1);
//
//   print(await books());
//
//   await deleteBook(b1.id);
//
//   print(await books());
// }
//
// class Book {
//   final int id;
//   final String title;
//   final int price;
//
//   Book({required this.id, required this.title, required this.price});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'price': price,
//     };
//   }
//   @override
//   String toString() {
//     return 'Book{id: $id, title: $title, price: $price}';
//   }
// }