import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/repositories/todo_app_repository.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/set_date.dart';
import 'todo_task_test.mocks.dart';

// class MockTodoAppRepository extends Mock implements TodoAppRepository {}

@GenerateMocks([TodoAppRepository])
void main() {
  late SetDate usecase;
  late MockTodoAppRepository mockTodoAppRepository;

  setUp(() {
    mockTodoAppRepository = MockTodoAppRepository();
    usecase = SetDate(mockTodoAppRepository);
  });

  final tTask = TaskDomain(
    name: "Task 1",
    duedate: "2023-01-01",
    description: "description",
    isCompleted: false,
  );

  test('Should allow the user to set date', () async {
    when(mockTodoAppRepository.setDate(any, any))
        .thenAnswer((_) async => Right(tTask));

    final result = await usecase(Params(index: 0, dateTime: "2023-01-01"));

    expect(result, Right(tTask));
    verify(mockTodoAppRepository.setDate(0, "2023-01-01"));
    verifyNoMoreInteractions(mockTodoAppRepository);
  });
}
