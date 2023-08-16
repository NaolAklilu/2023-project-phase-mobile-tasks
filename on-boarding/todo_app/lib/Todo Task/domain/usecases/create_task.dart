import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/task_domain.dart';
import '../repositories/todo_app_repository.dart';

class CreateTask implements UseCase<TaskDomain, Params> {
  final TodoAppRepository repository;

  CreateTask(this.repository);

  @override
  Future<Either<Failure, TaskDomain>> call(Params params) async {
    return await repository.addTask(params.task);
  }
}

class Params extends Equatable {
  final TaskDomain task;

  Params({required this.task});

  @override
  List<Object?> get props => [task];
}