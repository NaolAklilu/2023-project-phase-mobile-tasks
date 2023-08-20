import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/data/models/task_model.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/create_task.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/get_all_tasks.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/get_task.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/mark_completion.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/set_date.dart';
import 'package:todo_app/Todo%20Task/presentation/bloc/todo_task_bloc.dart';
import 'package:todo_app/core/error/failures.dart';

import 'todo_task_bloc_test.mocks.dart';

@GenerateMocks([CreateTask, GetTask, GetAllTasks, SetDate, MarkCompletion])
void main() {
  late TodoTaskBloc bloc;
  late MockCreateTask mockCreateTask;
  late MockGetTask mockGetTask;
  late MockGetAllTasks mockGetAllTasks;
  late MockSetDate mockSetDate;
  late MockMarkCompletion mockMarkCompletion;

  setUp(() {
    mockCreateTask = MockCreateTask();
    mockGetTask = MockGetTask();
    mockGetAllTasks = MockGetAllTasks();
    mockSetDate = MockSetDate();
    mockMarkCompletion = MockMarkCompletion();

    bloc = TodoTaskBloc(
      createTask: mockCreateTask,
      getTask: mockGetTask,
      getAllTasks: mockGetAllTasks,
      setDate: mockSetDate,
      markCompletion: mockMarkCompletion,
    );
  });

  final tTaskModel = TaskModel(
    id: "10",
    name: "Task 1",
    duedate: "2023-01-01",
    description: "repository implementation test",
    isCompleted: false,
  );

  final tTasks = <TaskModel>[tTaskModel];
  const tDate = "2023-01-01";
  const tIndex = 1;

  group("createTaskEvent", () {
    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, CreateTaskState] when usecase return Task",
        build: () {
          when(mockCreateTask(any)).thenAnswer((_) async => Right(tTaskModel));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateTaskEvent(taskEntity: tTaskModel)),
        expect: () =>
            [LoadingState(), LoadedTaskState(taskDomain: tTaskModel)]);

    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, ErrorState] when usecase return a Failure",
        build: () {
          when(mockCreateTask(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateTaskEvent(taskEntity: tTaskModel)),
        expect: () =>
            [LoadingState(), ErrorState(message: "SERVER_FAILURE_MESSAGE")]);
  });

  group("getTaskEvent", () {
    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, GetTask] when usecase return Task",
        build: () {
          when(mockGetTask(any)).thenAnswer((_) async => Right(tTaskModel));
          return bloc;
        },
        act: (bloc) => bloc.add(GetTaskEvent(index: tIndex)),
        expect: () =>
            [LoadingState(), LoadedTaskState(taskDomain: tTaskModel)]);

    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, ErrorState] when usecase return a Failure",
        build: () {
          when(mockGetTask(any)).thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(GetTaskEvent(index: tIndex)),
        expect: () =>
            [LoadingState(), ErrorState(message: "SERVER_FAILURE_MESSAGE")]);
  });

  group("getAllTasksEvent", () {
    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, GetAllTasks] when usecase return all tasks",
        build: () {
          when(mockGetAllTasks(any)).thenAnswer((_) async => Right(tTasks));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllTasksEvent()),
        expect: () => [LoadingState(), LoadedAllTasksState(tasks: tTasks)]);

    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, ErrorState] when usecase return a Failure",
        build: () {
          when(mockGetAllTasks(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(GetAllTasksEvent()),
        expect: () =>
            [LoadingState(), ErrorState(message: "SERVER_FAILURE_MESSAGE")]);
  });

  group("setDateEvent", () {
    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, SetDate] when usecase return Task",
        build: () {
          when(mockSetDate(any)).thenAnswer((_) async => Right(tTaskModel));
          return bloc;
        },
        act: (bloc) => bloc.add(SetDateEvent(index: tIndex, date: tDate)),
        expect: () =>
            [LoadingState(), LoadedTaskState(taskDomain: tTaskModel)]);

    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, ErrorState] when usecase return a Failure",
        build: () {
          when(mockSetDate(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(SetDateEvent(index: tIndex,date: tDate)),
        expect: () =>
            [LoadingState(), ErrorState(message: "SERVER_FAILURE_MESSAGE")]);
  });

  group("markCompletion", () {
    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, MarkCompletion] when usecase return Task",
        build: () {
          when(mockMarkCompletion(any)).thenAnswer((_) async => Right(tTaskModel));
          return bloc;
        },
        act: (bloc) => bloc.add(MarkCompletionEvent(index: tIndex)),
        expect: () =>
            [LoadingState(), LoadedTaskState(taskDomain: tTaskModel)]);

    blocTest<TodoTaskBloc, TodoTaskState>(
        "Should emit [LoadingState, ErrorState] when usecase return a Failure",
        build: () {
          when(mockMarkCompletion(any)).thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(MarkCompletionEvent(index: tIndex)),
        expect: () =>
            [LoadingState(), ErrorState(message: "SERVER_FAILURE_MESSAGE" )]);
  });
}
