import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TaskDomain extends Equatable {
  String name;
  String duedate;
  String description;
  bool isCompleted;

  TaskDomain({
    required this.name,
    required this.duedate,
    required this.description,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [
        name,
        duedate,
        description,
        isCompleted,
      ];
}
