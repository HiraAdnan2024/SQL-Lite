import 'package:sqflite/sqlite_api.dart';
import 'package:todo_sql_lite/database_provider/database_provider.dart';
import 'package:todo_sql_lite/model/todo_model.dart';

class TodoProvider {
  final DatabaseProvider _databaseProvider = DatabaseProvider.instance;

  Future<List<Todo>> getTodos() async {
    final Database db = await _databaseProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (index) {
      return Todo.fromMap(maps[index]);
    });
  }

  Future <void> addTodo(Todo todo) async {
    final Database db = await _databaseProvider.database;
    await db.insert('todos', todo.toMap());
  }

  Future<void> removeTodo(int id) async {
    final Database db = await _databaseProvider.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future <void> editTodo(Todo todo) async {
    final Database db = await _databaseProvider.database;
    await db.update('todos', todo.toMap(), where: 'id = ?',  whereArgs: [todo.id]);
  }

  Future <void> toggleComplete(int id , bool isCompleted) async {
    final Database db = await _databaseProvider.database;
    await db.update('todos', {'isCompleted' : isCompleted ? 1: 0}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> sortTodos(bool completedFirst) async {
    final Database db = await _databaseProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('todos', orderBy: completedFirst ? 'isCompleted DESC' : 'isCompleted ASC');
  }
}