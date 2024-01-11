import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider{
  DatabaseProvider._();

  static final DatabaseProvider instance = DatabaseProvider._();
  static Database? _database;


  Future<Database> get database async{
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
        path,
      version: 1,
      onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE todos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          isCompleted INTEGER
          )
          ''');
      },
    );
  }
}