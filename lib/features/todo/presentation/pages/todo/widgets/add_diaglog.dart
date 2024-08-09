// lib/features/todo/presentation/widgets/add_task_dialog.dart

import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController controller;
  final Future<void> Function(String) onAddTask;

  const AddTaskDialog({
    Key? key,
    required this.controller,
    required this.onAddTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Enter task here'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (controller.text.isNotEmpty) {
              await onAddTask(controller.text);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
