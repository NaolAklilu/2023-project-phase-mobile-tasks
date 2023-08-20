import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_local_data_source.dart';
import 'package:todo_app/Todo%20Task/data/models/task_model.dart';

import '../../../core/error/exceptions.dart';

// ignore: constant_identifier_names
const CACHED_TASK = 'CACHED_TASK';

class TodoTaskLocalDataSourceImpl implements TodoTaskLocalDataSource {
  final SharedPreferences sharedPreferences;

  TodoTaskLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheTask(TaskModel taskToCache) {
    print("******** $taskToCache");
    return sharedPreferences.setString(
      CACHED_TASK,
      json.encode(taskToCache.toJson()),
    );
  }

  @override
  Future<List<TaskModel>> getAllTasks(String key) {
    final jsonString = sharedPreferences.getString(key);

    if (jsonString != null) {
      final encodedTasks = json.decode(jsonString);
      return Future.value(encodedTasks.map((task) => TaskModel.fromJson(task)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<TaskModel> getLastTask(String key) {
    final jsonString = sharedPreferences.getString(key);
    if (jsonString != null) {
      return Future.value(TaskModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAllTasks(String key, List<TaskModel> taskModels) {
    return sharedPreferences.setString(
        key, json.encode(taskModels.map((task) => task.toJson())));
  }
}
