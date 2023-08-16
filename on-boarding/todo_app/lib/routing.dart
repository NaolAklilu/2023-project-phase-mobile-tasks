import 'package:flutter/material.dart';
import 'package:todo_app/Todo%20Task/presentation/pages/add_tasks.dart';
import 'package:todo_app/Todo%20Task/presentation/pages/on_boarding.dart';
import 'package:todo_app/Todo%20Task/presentation/pages/todo_list.dart';

class Routes {
  static const String onBoarding = "onBoard";
  static const String addTask = '/add';
  static const String list = '/list';
  static const String detail = '/detail';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.onBoarding: (context) => OnBoardingScreen(),
      Routes.addTask: (context) => AddTask(),
      Routes.list: (context) => TodoList()
    };
  }
}
