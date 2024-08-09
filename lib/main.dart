import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/todo/data/repositories/todo_repositories.dart';
import 'features/todo/domain/usecases/todo_usecase.dart';
import 'features/todo/presentation/pages/todo/home_screen.dart';
import 'features/todo/presentation/provider/todo_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<TodoRepository>(create: (_) => TodoRepositoryImpl()),
        Provider<CreateTask>(create: (context) => CreateTask(context.read<TodoRepository>())),
        Provider<DeleteTask>(create: (context) => DeleteTask(context.read<TodoRepository>())),
        Provider<UpdateTask>(create: (context) => UpdateTask(context.read<TodoRepository>())),
        Provider<FetchTasks>(create: (context) => FetchTasks(context.read<TodoRepository>())),
        ChangeNotifierProvider<TodoProvider>(
          create: (context) => TodoProvider(
            fetchTasksUseCase: context.read<FetchTasks>(),
            createTaskUseCase: context.read<CreateTask>(),
            updateTaskUseCase: context.read<UpdateTask>(),
            deleteTaskUseCase: context.read<DeleteTask>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoApp(),
      ),
    ),
  );
}
