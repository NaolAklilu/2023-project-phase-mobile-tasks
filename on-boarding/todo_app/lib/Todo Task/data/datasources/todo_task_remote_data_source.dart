import 'package:todo_app/Todo%20Task/data/models/task_model.dart';

import '../../domain/entities/task_domain.dart';

abstract class TodoTaskRemoteDataSource {
  Future<TaskModel> setDate(int index, String dateTime);
  Future<TaskModel> markCompletion(int index);
  Future<TaskModel> addTask(TaskDomain task);
  Future<List<TaskModel>> getAllTasks();
  Future<TaskModel> getTask(int index);
}