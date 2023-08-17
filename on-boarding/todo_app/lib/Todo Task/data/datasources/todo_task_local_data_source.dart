import 'package:todo_app/Todo%20Task/data/models/task_model.dart';

abstract class TodoTaskLocalDataSource {
  Future<TaskModel> getLastTask(String key);
  Future<List<TaskModel>> getAllTasks(String key);
  Future<void> cacheTask(String key, TaskModel taskToCache);
  Future<void> cacheAllTasks(String key, List<TaskModel> taskModels);
}
