import 'package:dartz/dartz.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_local_data_source.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_remote_data_source.dart';
import 'package:todo_app/Todo%20Task/data/models/task_model.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';
import 'package:todo_app/core/error/failures.dart';

import '../../../core/error/exceptions.dart';
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
  Future<Either<Failure, TaskDomain>> addTask(TaskDomain task) async {
    if (await networkInfo.isConnected) {
      final TaskModel taskModel = TaskModel(
        id: "1",
        name: task.name,
        duedate: task.duedate,
        description: task.description,
        isCompleted: task.isCompleted,
      );
      try {
        final remoteTask = await remoteDataSource.addTask(taskModel);
        await localDataSource.cacheTask(remoteTask);
        return Right(remoteTask);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskDomain>>> getAllTasks() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTasks = await remoteDataSource.getAllTasks();
        localDataSource.cacheAllTasks("tasks", remoteTasks);
        return Right(remoteTasks);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTasks = await localDataSource.getAllTasks("tasks");
        return Right(localTasks);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, TaskDomain>> getTask(int index) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTask = await remoteDataSource.getTask(index);
        localDataSource.cacheTask(remoteTask);
        return Right(remoteTask);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTask = await localDataSource.getLastTask(index.toString());
        return Right(localTask);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, TaskDomain>> markCompletion(int index) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTask = await remoteDataSource.markCompletion(index);
        localDataSource.cacheTask(remoteTask);
        return Right(remoteTask);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTask = await localDataSource.getLastTask(index.toString());
        return Right(localTask);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, TaskDomain>> setDate(
      int index, String dateTime) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTask = await remoteDataSource.setDate(index, dateTime);
        localDataSource.cacheTask(remoteTask);
        return Right(remoteTask);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTask = await localDataSource.getLastTask(index.toString());
        return Right(localTask);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
