import 'package:dartz/dartz.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_local_data_source.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_remote_data_source.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';
import 'package:todo_app/core/error/failures.dart';

import '../../../core/platform/network_info.dart';

class TodoAppRepositoryImpl implements TodoAppRepository {
  final TodoTaskRemoteDataSource remoteDataSource;
  final TodoTaskLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodoAppRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, TaskDomain>> addTask(TaskDomain task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TaskDomain>>> getAllTasks() {
    // TODO: implement getAllTasks
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TaskDomain>> getTask(int index) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TaskDomain>> markCompletion(int index) {
    // TODO: implement markCompletion
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TaskDomain>> setDate(int index, String dateTime) {
    // TODO: implement setDate
    throw UnimplementedError();
  }

}