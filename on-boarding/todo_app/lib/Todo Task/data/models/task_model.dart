import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';

// ignore: must_be_immutable
class TaskModel extends TaskDomain {
  final String id;

  TaskModel({
    required String name,
    required String duedate,
    required String description,
    required bool isCompleted,
    required this.id,
  }) : super(
            name: name,
            duedate: duedate,
            description: description,
            isCompleted: isCompleted);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    print("$json this is the json we are expecting ");
    return TaskModel(
      id: json['id'],
      name: "Naol's Task",
      duedate: json['duedate'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duedate': duedate,
      'description': description,
      'isCompleted': isCompleted
    };
  }
}
