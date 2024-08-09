import 'package:first_project/features/todo/data/datasources/sql_lite.dart';
import 'package:first_project/features/todo/data/models/sql_model.dart';

abstract class TodoRepository {
  Future<void> createTask(Task task);
  Future<void> deleteTask(int id);
  Future<void> updateTask(Task task);
  Future<List<Task>> getTasks();
}

class TodoRepositoryImpl implements TodoRepository {
  final SQLite _sqlite = SQLite();

  @override
  Future<void> createTask(Task task) async {
    await _sqlite.insertTodo(task.todo!, task.status!);
  }

  @override
  Future<void> deleteTask(int id) async {
    await _sqlite.deleteTodo(id);
  }

  @override
  Future<void> updateTask(Task task) async {
    await _sqlite.updateTodo(task.id!, task.todo!, task.status!);
  }

  @override
  Future<List<Task>> getTasks() async {
    final data = await _sqlite.getAllTodos();
    final taskInstance = Task(); // Create an instance of Task
    return data.map((item) => taskInstance.fromMap(item)).toList();
  }
}
