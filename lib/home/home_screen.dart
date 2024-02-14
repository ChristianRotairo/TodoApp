import 'package:flutter/material.dart';
import 'package:first_project/todo/todo_tile.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

List todoApp = [
  ["Make a cup of asdsad", false],
  ["Go to the gym", false],
];

class _TodoAppState extends State<TodoApp> {
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoApp[index][1] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: ListView.builder(
        itemCount: todoApp.length,
        itemBuilder: (context, index) {
          return TodoTile(
              todoName: todoApp[index][0],
              isCompleted: todoApp[index][1],
              onChanged: (value) => checkBoxChanged(value, index));
        },
      ),
    );
  }
}
