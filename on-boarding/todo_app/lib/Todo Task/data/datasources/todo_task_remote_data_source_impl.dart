import 'dart:convert';

import 'package:todo_app/Todo%20Task/data/datasources/todo_task_remote_data_source.dart';
import 'package:todo_app/Todo%20Task/data/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/core/error/exceptions.dart';

class TodoTaskRemoteDataSourceImp implements TodoTaskRemoteDataSource {
  final http.Client client;

  TodoTaskRemoteDataSourceImp({required this.client});

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    final http.Response response = await client.post(
        Uri.parse('httt://todotask/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()));

    if (response.statusCode == 200) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final response = await client.get(
      Uri.parse('http://todotask/all'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final taskList = <TaskModel>[];
      final decodedTasks = jsonDecode(response.body);

      for (var task in decodedTasks) {
        taskList.add(TaskModel.fromJson(task));
      }
      return taskList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskModel> getTask(int index) async {
    final http.Response response = await client.get(
        Uri.parse('http://todotask/$index'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskModel> markCompletion(int index) async {
    final http.Response response = await client.put(
        Uri.parse('http/todotask/$index/edit'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return TaskModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskModel> setDate(int index, String dateTime) async {
    final http.Response response = await client.put(
        Uri.parse('http/todotask/index?$index/date?$dateTime/edit'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return TaskModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
