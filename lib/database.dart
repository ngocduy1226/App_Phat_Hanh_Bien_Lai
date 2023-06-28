import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:myshop/models/brand.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE brands(id INTEGER PRIMARY KEY, content TEXT, denominations DOUBLE)',
        );
      },
      version: 1,
    );
  }

  Future<Brand> addBrand(Brand brand) async {
    final db = await initializeDB();
    await db.insert('brands', brand.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return brand;
  }

  Future<List<Brand>> brands() async {
  // Get a reference to the database.
  final db = await initializeDB();

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('brands');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Brand(
      id: maps[i]['id'],
      content: maps[i]['content'],
      denominations: maps[i]['denominations'],
    );
  });
}

}
