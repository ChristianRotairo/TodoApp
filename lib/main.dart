import 'package:flutter/material.dart';
import 'package:first_project/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: const ColorScheme.Colors.black,
        useMaterial3: true,
      ),
      home:  TodoApp(),
    );
  }
}
