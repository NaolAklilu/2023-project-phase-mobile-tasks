import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem(this.taskTitle, this.dueDate, this.isCompleted, {super.key});

  final String taskTitle;
  final String dueDate;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, top: 10),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text(
                    taskTitle[0],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(taskTitle)
              ],
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 20, top: 6, bottom: 6),
                  padding: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(width: 3, color: Colors.red))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dueDate,
                          style: TextStyle(fontFamily: "Inter", fontSize: 12),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child:
                              isCompleted ? Text("Completed") : Text("Pending"),
                        )
                      ]),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
