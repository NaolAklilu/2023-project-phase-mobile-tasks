import 'package:flutter/material.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/presentation/widgets/app_header.dart';
import 'package:todo_app/Todo%20Task/presentation/widgets/item_detail_container.dart';

class TaskDetail extends StatelessWidget {
  final TaskDomain task;

  const TaskDetail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              ItemDetailContainer("Title", task.name, 50),
              ItemDetailContainer(
                  "Description", task.description, 80),
              ItemDetailContainer("Deadline", task.duedate, 50)
            ],
          )
        ],
      ),
    );
  }
}
