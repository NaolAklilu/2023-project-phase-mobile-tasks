import 'package:flutter/material.dart';
import 'package:todo_app/routing.dart';
import 'package:todo_app/widget/app_header.dart';

import '../widget/list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader("Todo List"),
          Column(
            children: [
              SizedBox(
                height: 200,
                child: Image.asset("assets/images/stict-man1.jpg"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text("Tasks List",
                        style: TextStyle(fontWeight: FontWeight.w900)),
                  )
                ],
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.detail);
                  },
                  child: ListItem("UI/UX App Design", "June 1, 2023")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.detail);
                  },
                  child: ListItem("View Candidates", "April 2, 2023")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.detail);
                  },
                  child: ListItem("My App Design", "August 22, 2023")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.detail);
                  },
                  child: ListItem("Add Feature", "April 10, 2023")),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.addTask);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(225, 20),
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text("Create Task"))
            ],
          )
        ],
      ),
    );
  }
}
