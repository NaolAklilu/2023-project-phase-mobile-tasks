import 'package:todo_app/Todo%20Task/data/models/task_model.dart';

abstract class TodoTaskLocalDataSource {
  Future<TaskModel> getLastTask();
  Future<List<TaskModel>> getAllTasks();
  Future<void> cacheTask(TaskModel taskToCache);
  Future<void> cacheAllTasks();
}
