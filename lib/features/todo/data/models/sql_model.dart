

import 'package:first_project/features/todo/data/datasources/sql_lite.dart';

class Task{
  final int? id;
  final String? todo;
  bool? status;

  Task({
    this.id,
    this.todo,
    this.status,
  });

  SQLite helper = SQLite();

  List<Task> tasks = [];

  createTask(Task task) async{
    await helper.insertTodo(task.todo!, task.status!);
    tasks.clear();
    await getTasks();
  }

  deleteTask(Task task) async{
    final index = tasks.indexOf(task);
    tasks.removeAt(index);
    await helper.deleteTodo(task.id!);
  }

  toggleTask(Task task) async {
  final index = tasks.indexOf(task);
  tasks[index].status = !tasks[index].status!; // Toggle the status
  await helper.updateTodo(task.id!, task.todo!, tasks[index].status!);

}


  getTasks() async{
    for(var item in await helper.getAllTodos()){
      tasks.add(fromMap(item));
    }
  }


  Task fromMap(Map<String, dynamic> map){
    return Task(
      id: map['id'],
      todo: map['todo'],
      status: map['status'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'todo': todo,
      'status': status! ? 1 : 0,
    };
  }
}