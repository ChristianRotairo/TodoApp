// lib/features/todo/presentation/todo_app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_project/features/todo/presentation/provider/todo_provider.dart';
import 'widgets/add_diaglog.dart';
import 'widgets/edit_dialog.dart';

class TodoApp extends StatefulWidget {
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.todos.isNotEmpty) {
            return ListView.builder(
              itemCount: todoProvider.todos.length,
              itemBuilder: (context, index) {
                final task = todoProvider.todos[index];
                final bool isChecked = task.status ?? false;

                return ListTile(
                  leading: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    value: isChecked,
                    onChanged: (bool? value) async {
                      if (value != null) {
                        await todoProvider.updateTodo(
                          task.id!,
                          task.todo!,
                          value,
                        );
                      }
                    },
                  ),
                  title: Text(
                    task.todo!,
                    style: TextStyle(
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditTaskDialog(context, todoProvider, task.id!, task.todo!);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await todoProvider.deleteTodo(task.id!);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No tasks available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialog(
          controller: controller,
          onAddTask: (taskText) async {
            await Provider.of<TodoProvider>(context, listen: false).addTodo(taskText);
          },
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, TodoProvider todoProvider, int id, String currentTitle) {
    final TextEditingController controller = TextEditingController(text: currentTitle);

    showDialog(
      context: context,
      builder: (context) {
        return EditTaskDialog(
          controller: controller,
          onSaveTask: (newTitle) async {
            final currentTask = todoProvider.todos.firstWhere((task) => task.id == id);
            final currentStatus = currentTask.status ?? false;
            await todoProvider.updateTodo(
              id,
              newTitle,
              currentStatus,
            );
          },
        );
      },
    );
  }
}
