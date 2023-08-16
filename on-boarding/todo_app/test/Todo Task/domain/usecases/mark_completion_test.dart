import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/mark_completion.dart';

import 'add_task_test.mocks.dart';

void main() {
  late MarkCompletion usecase;
  late MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = MarkCompletion(mockTodoAppRepository);
  });

  final tTask = TaskDomain(
    name: "Task 2",
    duedate: "2023-01-02",
    description: "Mark Completion usecase test",
    isCompleted: true,
  );

  test("Should mark task completion", () async {
    when(mockTodoAppRepository.markCompletion(any)).thenAnswer(
      (_) async => Right(tTask),
    );

    var result = await usecase.execute(index: 0);

    expect(result, Right(tTask));
    verify(mockTodoAppRepository.markCompletion(0));
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}
