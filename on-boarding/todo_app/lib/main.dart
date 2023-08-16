import 'package:flutter/material.dart';
import 'package:todo_app/Todo%20Task/presentation/pages/on_boarding.dart';
import 'package:todo_app/routing.dart';

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
      routes: Routes.getRoutes(),
      home: OnBoardingScreen(),
    );
  }
}
