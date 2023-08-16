import 'package:flutter/material.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/presentation/pages/add_tasks.dart';
import 'package:todo_app/Todo%20Task/presentation/pages/task_detail.dart';
import 'package:todo_app/Todo%20Task/presentation/widgets/app_header.dart';
import 'package:todo_app/Todo%20Task/presentation/widgets/list_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var tasks = <TaskDomain>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
              for (var task in tasks)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetail(
                          task: TaskDomain(
                              name: task.name,
                              duedate: task.duedate,
                              description: task.description,
                              isCompleted: task.isCompleted),
                        ),
                      ),
                    );
                  },
                  child: ListItem(task.name, task.duedate, task.isCompleted),
                ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final TaskDomain result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddTask()),
                  );

                  TaskDomain task = TaskDomain(
                      name: result.name,
                      duedate: result.duedate,
                      description: result.description,
                      isCompleted: result.isCompleted);

                  setState(() {
                    tasks.add(task);
                  });
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(225, 20),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text("Create Task"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
