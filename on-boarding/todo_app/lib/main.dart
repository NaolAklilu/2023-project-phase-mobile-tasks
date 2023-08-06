import 'package:flutter/material.dart';
import 'package:todo_app/screen/add_tasks.dart';
// import 'package:todo_app/screen/on_boarding.dart';
import 'package:todo_app/screen/task_detail.dart';
import 'package:todo_app/screen/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: OnBoardingScreen());
        // body: AddTask());
        body: TodoList());
    // body: TaskDetail());
  }
}
