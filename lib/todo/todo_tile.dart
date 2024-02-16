 import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  final String todoName;
  final bool isCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? onDeleted;

  TodoTile({
    super.key,
    required this.todoName,
    required this.isCompleted,
    this.onChanged,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    // Parent Container
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDeleted,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            )
          ],
        ),
        child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                // checkbox
                Checkbox(
                  value: isCompleted,
                  onChanged: onChanged,
                ),
                // Todo List
                Text(
                  todoName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            )),
      ),
    );
  }
}