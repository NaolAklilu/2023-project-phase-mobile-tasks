import 'package:flutter/material.dart';
import 'package:todo_app/widget/app_header.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeader("Create New Task"),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 3),
                child: Text(
                  "Main task name",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 3),
                  child: Text(
                    "Due Date",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                  )),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 3),
                child: Text(
                  "Description",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0))),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white // Background color
                        ),
                    child: const Text('Add Task'),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
