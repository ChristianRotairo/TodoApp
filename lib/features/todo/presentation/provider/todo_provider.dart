import 'package:flutter/foundation.dart';
import '../../data/models/sql_model.dart';
import '../../domain/usecases/todo_usecase.dart';

class TodoProvider with ChangeNotifier {
  final FetchTasks fetchTasksUseCase;
  final CreateTask createTaskUseCase;
  final UpdateTask updateTaskUseCase;
  final DeleteTask deleteTaskUseCase;

  List<Task> _todos = [];

  List<Task> get todos => _todos;

  TodoProvider({
    required this.fetchTasksUseCase,
    required this.createTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      _todos = await fetchTasksUseCase.execute();
      notifyListeners();
    } catch (e) {
      // Handle errors if needed
      print('Failed to load tasks: $e');
    }
  }

  Future<void> addTodo(String todo) async {
    final newTask = Task(todo: todo, status: false);
    try {
      await createTaskUseCase.execute(newTask);
      _loadTasks(); // Refresh the data
    } catch (e) {
      // Handle errors if needed
      print('Failed to add task: $e');
    }
  }

  Future<void> updateTodo(int id, String todo, bool status) async {
    final task = Task(id: id, todo: todo, status: status);
    try {
      await updateTaskUseCase.execute(task);
      // Directly update the list instead of reloading all tasks
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        _todos[index] = task;
        notifyListeners();
      }
    } catch (e) {
      // Handle errors if needed
      print('Failed to update task: $e');
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await deleteTaskUseCase.execute(id);
      _loadTasks(); // Refresh the data
    } catch (e) {
      // Handle errors if needed
      print('Failed to delete task: $e');
    }
  }
}
