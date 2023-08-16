import 'package:dartz/dartz.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';

import '../../../error/failures.dart';

class SetDate {
  final TodoAppRepository repository;

  SetDate(this.repository);

  Future<Either<Failure, TaskDomain>> execute(
      {required TaskDomain task}) async {
    return await repository.setDate(task);
  }
}
