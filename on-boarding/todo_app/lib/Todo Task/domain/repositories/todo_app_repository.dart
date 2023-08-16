import 'package:dartz/dartz.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/core/error/failures.dart';

abstract class TodoAppRepository {
  Future<Either<Failure, TaskDomain>> setDate(int index, String dateTime);
  Future<Either<Failure, TaskDomain>> markCompletion(int index);
  Future<Either<Failure, TaskDomain>> addTask(TaskDomain task);
  Future<Either<Failure, List<TaskDomain>>> getAllTasks();
  Future<Either<Failure, TaskDomain>> getTask(int index);
}