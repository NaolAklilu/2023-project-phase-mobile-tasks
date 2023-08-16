import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/presentation/widgets/app_header.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                    ),
                    onChanged: (v) {
                      setState(() {
                        nameController.text = v;
                      });
                    }),
                SizedBox(height: 16),
                Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 3),
                    child: Text(
                      "Due Date",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                    )),
                TextField(
                  controller: dueDateController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            BorderSide(color: Colors.black, width: 2.0)),
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: Colors.deepOrange,
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);

                      setState(() {
                        dueDateController.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
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
                  controller: descriptionController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  onChanged: (v) {
                    setState(() {
                      descriptionController.text = v;
                    });
                  },
                ),
                Row(
                  children: [
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 3),
                        child: Text(
                          "Is Completed? ",
                          style:
                              TextStyle(color: Colors.deepOrange, fontSize: 16),
                        )),
                    Checkbox(
                      value: isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          isCompleted = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          TaskDomain(
                              name: nameController.text,
                              duedate: dueDateController.text,
                              description: descriptionController.text,
                              isCompleted: isCompleted),
                        );
                      },
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
      ),
    );
  }
}
