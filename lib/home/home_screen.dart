import 'package:first_project/todo/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:first_project/todo/todo_tile.dart';

class TodoApp extends StatefulWidget {
 
   TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

 final __controller = TextEditingController();

// array of data
List todoApp = [
  ["Make a cup of coffee", false],
  ["Go to the gym", false],
];

class _TodoAppState extends State<TodoApp> {
  TextEditingController __controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoApp[index][1] = value ?? false;
    });
  }

// save new task
  void saveNewTask() {
    setState(() {
      todoApp.add([__controller.text, false]);
      __controller.clear();
    });
    Navigator.of(context).pop();
  }

// Create new task
  void newTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: __controller,
          onSaved: saveNewTask,
          onCancelled: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newTask,
        child: const Icon(Icons.add),
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
