import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/usecases/usecase.dart';

import '../entities/task_domain.dart';

class GetTask implements UseCase<TaskDomain, GetTaskParams> {
  final TodoAppRepository repository;

  GetTask(this.repository);

  @override
  Future<Either<Failure, TaskDomain>> call(GetTaskParams params) async {
    return await repository.getTask(params.index);
  }
}

class GetTaskParams extends Equatable {
  final int index;

  GetTaskParams({required this.index});

  @override
  List<Object?> get props => [index];
}
