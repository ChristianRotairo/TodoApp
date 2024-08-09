// lib/features/todo/presentation/widgets/edit_task_dialog.dart

import 'package:flutter/material.dart';

class EditTaskDialog extends StatelessWidget {
  final TextEditingController controller;
  final Future<void> Function(String) onSaveTask;

  const EditTaskDialog({
    Key? key,
    required this.controller,
    required this.onSaveTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Task'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Enter new task here'),
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
              await onSaveTask(controller.text);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
