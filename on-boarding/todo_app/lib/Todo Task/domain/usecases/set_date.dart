import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';
import 'package:todo_app/core/usecases/usecase.dart';

import '../../../core/error/failures.dart';

class SetDate implements UseCase<TaskDomain, Params> {
  final TodoAppRepository repository;

  SetDate(this.repository);

  @override
  Future<Either<Failure, TaskDomain>> call(Params params) async {
    return await repository.setDate(params.index, params.dateTime);
  }
}

class Params extends Equatable {
  final int index;
  final String dateTime;

  Params({required this.index, required this.dateTime});

  @override
  List<Object?> get props => [index, dateTime];
}
