import 'package:todo_app/Todo%20Task/data/models/task_model.dart';

abstract class TodoTaskLocalDataSource {
  Future<TaskModel> getLastTask();
  Future<void> cacheTask(TaskModel taskToCache);
}
