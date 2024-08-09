import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLite {
  Future<Database> openTodoDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'db_todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE todo_app(id INTEGER PRIMARY KEY AUTOINCREMENT, todo TEXT, status INTEGER)',
        );
      },
    );
  }

  // Insert data into the database
  Future<void> insertTodo(String todo, bool status) async {
    final db = await openTodoDatabase();
    await db.insert(
      'todo_app',
      {
        'todo': todo,
        'status': status ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Delete data from the database
  Future<void> deleteTodo(int id) async {
    final db = await openTodoDatabase();
    await db.delete(
      'todo_app',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update data in the database
  Future<void> updateTodo(int id, String todo, bool status) async {
    final db = await openTodoDatabase();
    await db.update(
      'todo_app',
      {
        'todo': todo,
        'status': status ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get all data from the database
  Future<List<Map<String, dynamic>>> getAllTodos() async {
    final db = await openTodoDatabase();
    final result = await db.query('todo_app');
    final todos = result.map((row) => {
      'id': row['id'],
      'todo': row['todo'],
      'status': row['status'] == 1,
    }).toList();
    return todos;
  }
}
