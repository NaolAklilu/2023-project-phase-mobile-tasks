import 'package:flutter/material.dart';
import 'package:todo_app/widget/app_header.dart';
import 'package:todo_app/widget/item_detail_container.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeader("Task Detail"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 250,
              child: Image.asset("assets/images/item-detail.png"),
            ),
            ItemDetailContainer("Title", "UI/UX App Design", 50),
            ItemDetailContainer(
                "Description", "App description goes here...", 80),
            ItemDetailContainer("Deadline", "April 1, 2023", 50)
          ],
        )
      ],
    );
  }
}
