import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

class GetAllTasks implements UseCase<List<TaskDomain>, Params> {
  final TodoAppRepository repository;

  GetAllTasks(this.repository);

  @override
  Future<Either<Failure, List<TaskDomain>>> call(Params params) async {
    return repository.getAllTasks();
  }
}

class Params extends Equatable {
  Params();

  @override
  List<Object?> get props => [];
}
