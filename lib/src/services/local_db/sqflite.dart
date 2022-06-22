import 'dart:io';
import 'dart:async';

import 'package:muraita_2_0/src/services/local_db/local_db_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLite {
  SQLite._();
  static final instance = SQLite._();

  static const _dbName = 'muraita.db';

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, _dbName);
    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(LocalDBTable.productSearch);

    ///execute another table here if needed
    // await db.execute(LocalDBTable.anotherDBTableHere;
  }

  ///Database CRUD operations
  Future saveData({table, data, conflictAlgo}) async {
    final db = await instance.database;
    return await db.insert(table, data.toMap(),
        conflictAlgorithm: conflictAlgo);
  }

  Future delete({table, id}) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future deleteAll({table}) async {
    final db = await instance.database;
    return await db.delete(table);
  }

  Future update({table, data, id}) async {
    final db = await instance.database;
    return await db
        .update(table, data.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future getById({table, id}) async {
    final db = await instance.database;
    return await db.query(table, where: 'id = ?', whereArgs: [id]);
  }

  Future getAll({table}) async {
    final db = await instance.database;
    return db.query(table);
  }
}
