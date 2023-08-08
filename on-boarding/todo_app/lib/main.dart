import 'package:flutter/material.dart';
import 'package:todo_app/routing.dart';
import 'package:todo_app/screen/on_boarding.dart';

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
