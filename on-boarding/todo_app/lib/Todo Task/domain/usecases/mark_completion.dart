import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';
import 'package:todo_app/core/usecases/usecase.dart';

import '../../../core/error/failures.dart';

class MarkCompletion implements UseCase<TaskDomain, Params> {
  final TodoAppRepository repository;

  MarkCompletion(this.repository);

  @override
  Future<Either<Failure, TaskDomain>> call(Params params) async {
    return await repository.markCompletion(params.index);
  }
}

class Params extends Equatable {
  final int index;

  Params({required this.index});

  @override
  List<Object?> get props => [index];
}
