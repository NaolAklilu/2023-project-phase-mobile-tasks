import 'package:dartz/dartz.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/error/failures.dart';

abstract class TodoAppRepository {
  Future<Either<Failure, TaskDomain>> setDate(TaskDomain task);
  Future<Either<Failure, TaskDomain>> markCompletion(int index);
}
