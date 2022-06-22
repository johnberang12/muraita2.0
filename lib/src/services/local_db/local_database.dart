import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'local_db_table.dart';

class LocalDatabase {
  LocalDatabase._();
  static final instance = LocalDatabase._();

  static const _dbName = 'muraita_2_0.db';

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    // ignore: await_only_futures
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = '${directory.path}/$_dbName';
    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(LocalDBTable.productSearch);

    ///add table here if needed
  }

  ///
  Future saveData(String table, Map<String, dynamic> data, conflictAlgo) async {
    final db = await instance.database;
    print('inserting $data to $table');
    return await db.insert(table, data, conflictAlgorithm: conflictAlgo);
  }

  Future update(String table, Map<String, dynamic> data, String id) async {
    final db = await instance.database;
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  Future delete(String table, String id) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future getById(String table, String id) async {
    final db = await instance.database;
    return await db.query(table, where: 'id = ?', whereArgs: [id]);
  }

  Future getAll(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }
}
