import 'dart:io';

import 'package:calculatorapp/models/historymodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  DatabaseHelper._();
  static final DatabaseHelper dbhelp = new DatabaseHelper._();

//  factory DatabaseHelper() => _instance;

  final String tableExpression = "expressionTable";
  final String columnId = "id";
  final String columnExpression = "expression";
  final String columnNotes = "notes";
  final String columnImage = "image";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(
        documentDirectory.path, "maindb.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableExpression($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnExpression TEXT NOT NULL, $columnNotes TEXT, $columnImage TEXT)");
  }

  Future<int> saveExpression(HistoryModel historyModel) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableExpression", historyModel.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> getAllExpressions() async {
    var dbClient = await db;
    var result = await dbClient.query(tableExpression);

    return result.toList();
  }

  Future<HistoryModel> getExpression(int id) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery("SELECT * FROM $tableExpression WHERE $columnId = $id");
    if (result.length == 0) return null;
    return new HistoryModel.fromMap(result.first);
  }

  Future<List<Map<String, dynamic>>> searchExpression(String text) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery("SELECT * FROM $tableExpression WHERE $columnNotes LIKE ?", ["%$text%"]);
    if (result.length == 0) return null;
    return result.toList();
  }

  Future<int> updateExpression(int id, String notes) async {
    var dbClient = await db;
    return await dbClient.rawUpdate('UPDATE $tableExpression SET notes = ? WHERE id = ?', [notes, id]);
  }

  Future<int> deleteExpression(int id) async {
    var dbClient = await db;

    return await dbClient.delete(tableExpression,
        where: "$columnId = ?", whereArgs: [id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}