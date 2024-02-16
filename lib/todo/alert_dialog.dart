import 'package:first_project/todo/save_close.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
final controller;
VoidCallback onSaved;
VoidCallback onCancelled;

   DialogBox({super.key,
   required this.controller,
   required this.onSaved,
   required this.onCancelled});

  @override
  Widget build(BuildContext context) {
   return AlertDialog(
  backgroundColor: Colors.yellow,
  content: SizedBox(
    height: 112,

    child: Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Add new todo",
          ),
        ),
        
        Row(
          mainAxisAlignment:MainAxisAlignment.end,
          children: [
          Button(text: "Save", onPressed: onSaved),
          const SizedBox(width: 10),
          Button(text: "Cancel", onPressed: onCancelled),
        ],)
        
      ],
    ),
  ),
);
  }}