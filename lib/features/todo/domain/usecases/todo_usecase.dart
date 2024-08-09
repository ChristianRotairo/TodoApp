import '../../data/models/sql_model.dart';
import '../../data/repositories/todo_repositories.dart';

class CreateTask {
  final TodoRepository repository;

  CreateTask(this.repository);

  Future<void> execute(Task task) async {
    await repository.createTask(task);
  }
}

class DeleteTask {
  final TodoRepository repository;

  DeleteTask(this.repository);

  Future<void> execute(int id) async {
    await repository.deleteTask(id);
  }
}

class UpdateTask {
  final TodoRepository repository;

  UpdateTask(this.repository);

  Future<void> execute(Task task) async {
    await repository.updateTask(task);
  }
}

class FetchTasks {
  final TodoRepository repository;

  FetchTasks(this.repository);

  Future<List<Task>> execute() async {
    return await repository.getTasks();
  }
}
