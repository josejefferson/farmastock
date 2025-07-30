import 'dart:async';
import 'dart:io' as io;
import 'package:farmastock/modelo/base_modal.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    _db ??= await init();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> init() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database.db");
    return openDatabase(path, version: 1);
  }

  Future<List<T>> query<T extends BaseModel>({
    required String table,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    final result = await (await db).query(table);
    return result.map((map) => fromMap(map)).toList();
  }

  Future<int> insert<T extends BaseModel>({
    required String table,
    required T model,
  }) async {
    return await (await db).insert(table, model.toMap());
  }

  Future<int> update<T extends BaseModel>({
    required String table,
    required T model,
  }) async {
    return await (await db).update(
      table,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> delete<T extends BaseModel>({
    required String table,
    required T model,
  }) async {
    return await (await db).delete(
      table,
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }
}
