import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/task_domain.dart';
import '../repositories/todo_app_repository.dart';

class CreateTask implements UseCase<TaskDomain, CreateTaskParams> {
  final TodoAppRepository repository;

  CreateTask(this.repository);

  @override
  Future<Either<Failure, TaskDomain>> call(CreateTaskParams params) async {
    return await repository.addTask(params.task);
  }
}

class CreateTaskParams extends Equatable {
  final TaskDomain task;

  CreateTaskParams({required this.task});

  @override
  List<Object?> get props => [task];
}