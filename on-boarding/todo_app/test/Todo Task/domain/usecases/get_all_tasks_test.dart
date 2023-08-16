import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/get_all_tasks.dart';

import 'todo_task_test.mocks.dart';

@GenerateMocks([TodoAppRepository])
void main() {
  late GetAllTasks usecase;
  late MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = GetAllTasks(mockTodoAppRepository);
  });

  final tasks = <TaskDomain>[];

  test('Should allow the user get all tasks', () async {
    when(mockTodoAppRepository.getAllTasks())
        .thenAnswer((_) async => Right(tasks));

    final result = await usecase(Params());

    expect(result, Right(tasks));
    verify(mockTodoAppRepository.getAllTasks());
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}
