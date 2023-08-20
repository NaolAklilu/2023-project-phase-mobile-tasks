import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/get_task.dart';

import 'todo_task_test.mocks.dart';

// @GenerateMocks([TodoAppRepository])
void main() {
  late GetTask usecase;
  late MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = GetTask(mockTodoAppRepository);
  });

  final tTask = TaskDomain(
    name: "Task",
    duedate: "2023-01-01",
    description: "Test get specific task",
    isCompleted: false,
  );

  test('Should allow the user to get specific task', () async {
    when(mockTodoAppRepository.getTask(0))
        .thenAnswer((_) async => Right(tTask));

    final result = await usecase(GetTaskParams(index: 0));

    expect(result, Right(tTask));
    verify(mockTodoAppRepository.getTask(0));
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}

