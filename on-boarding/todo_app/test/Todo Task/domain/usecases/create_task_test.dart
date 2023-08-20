import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/create_task.dart';

import 'todo_task_test.mocks.dart';

// @GenerateMocks([TodoAppRepository])
void main() {
  late CreateTask usecase;
  late MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = CreateTask(mockTodoAppRepository);
  });

  final tTask = TaskDomain(
    name: "Task 1",
    duedate: "2023-01-01",
    description: "create new task",
    isCompleted: false,
  );

  test('Should allow the user to create new task', () async {
    when(mockTodoAppRepository.addTask(tTask))
        .thenAnswer((_) async => Right(tTask));

    final result = await usecase(CreateTaskParams(task: tTask));

    expect(result, Right(tTask));
    verify(mockTodoAppRepository.addTask(tTask));
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}
