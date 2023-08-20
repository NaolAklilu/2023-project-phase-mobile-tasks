import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_local_data_source.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_remote_data_source.dart';
import 'package:todo_app/Todo%20Task/data/models/task_model.dart';
import 'package:todo_app/Todo%20Task/data/repositories/todo_app_repository_impl.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/core/error/exceptions.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/platform/network_info.dart';

import 'todo_app_repository_impl_test.mocks.dart';

@GenerateMocks([TodoTaskLocalDataSource, TodoTaskRemoteDataSource, NetworkInfo])
void main() {
  late TodoAppRepositoryImpl repository;
  late MockTodoTaskRemoteDataSource mockRemoteDataSource;
  late MockTodoTaskLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTodoTaskRemoteDataSource();
    mockLocalDataSource = MockTodoTaskLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TodoAppRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('createTask', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    final tTaskEntity = TaskDomain(
      name: "Task 1",
      duedate: "2023-01-01",
      description: "repository implementation test",
      isCompleted: false,
    );

    final tTaskModel = TaskModel(
      id: "1",
      name: "Task 1",
      duedate: "2023-01-01",
      description: "repository implementation test",
      isCompleted: false,
    );

    const tKey = "CACHED_TASK";

    test("Should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addTask(tTaskModel))
          .thenAnswer((_) async => tTaskModel);
      await repository.addTask(tTaskEntity);
      verify(mockNetworkInfo.isConnected);
    });

    test(
        "should return create new task when call to remote data source is successful",
        () async {
      when(mockRemoteDataSource.addTask(tTaskModel))
          .thenAnswer((_) async => tTaskModel);
      final result = await repository.addTask(tTaskEntity);
      verify(mockRemoteDataSource.addTask(tTaskModel));
      expect(result, equals(Right(tTaskModel)));
    });

    test("Should cache the tast when call to remote data source is successful",
        () async {
      when(mockRemoteDataSource.addTask(tTaskModel))
          .thenAnswer((_) async => tTaskModel);

      await repository.addTask(tTaskEntity);
      verify(mockRemoteDataSource.addTask(tTaskModel));
      verify(mockLocalDataSource.cacheTask(tTaskModel));
    });

    test(
        "Should return server failure when call to remote data source is unsuccessful",
        () async {
      when(mockRemoteDataSource.addTask(tTaskModel))
          .thenThrow(ServerException());

      final result = await repository.addTask(tTaskEntity);
      verify(mockRemoteDataSource.addTask(tTaskModel));
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('getTask', () {
    const tIndex = 1;
    const tKey = "1";
    final tTaskModel = TaskModel(
      id: "1",
      name: "Task 1",
      duedate: "2023-01-01",
      description: "repository implementation test",
      isCompleted: false,
    );

    group('When device online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test("Should check if the device is online", () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getTask(tIndex))
            .thenAnswer((_) async => tTaskModel);
        await repository.getTask(tIndex);
        verify(mockNetworkInfo.isConnected);
      });

      test(
          "should return the task when call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.getTask(tIndex))
            .thenAnswer((_) async => tTaskModel);
        final result = await repository.getTask(tIndex);
        verify(mockRemoteDataSource.getTask(tIndex));
        expect(result, equals(Right(tTaskModel)));
      });

      test(
          "Should cache the tast when call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.getTask(tIndex))
            .thenAnswer((_) async => tTaskModel);

        await repository.getTask(tIndex);
        verify(mockRemoteDataSource.getTask(tIndex));
        verify(mockLocalDataSource.cacheTask(tTaskModel));
      });

      test(
          "Should return server failure when call to remote data source is unsuccessful",
          () async {
        when(mockRemoteDataSource.getTask(tIndex)).thenThrow(ServerException());

        final result = await repository.getTask(tIndex);
        verify(mockRemoteDataSource.getTask(tIndex));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group("When device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("Should return last locally cached task if there is cached task",
          () async {
        when(mockLocalDataSource.getLastTask(tKey))
            .thenAnswer((_) async => tTaskModel);

        final result = await repository.getTask(tIndex);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTask(tKey));
        expect(result, equals(Right(tTaskModel)));
      });

      test("Should return CachedFailure if there is no cached task", () async {
        when(mockLocalDataSource.getLastTask(tKey)).thenThrow(CacheException());

        final result = await repository.getTask(tIndex);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTask(tKey));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getAllTasks', () {
    final tTasks = <TaskModel>[];
    const tKey = "task key";

    test("Should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repository.getAllTasks();
      verify(mockNetworkInfo.isConnected);
    });

    group("when the device is online", () {

      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          "should return all tasks when call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.getAllTasks())
            .thenAnswer((_) async => tTasks);
        final result = await repository.getAllTasks();
        verify(mockRemoteDataSource.getAllTasks());
        expect(result, equals(Right(tTasks)));
      });

      test(
          "Should cache all tasts when call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.getAllTasks())
            .thenAnswer((_) async => tTasks);

        await repository.getAllTasks();
        verify(mockRemoteDataSource.getAllTasks());
        verify(mockLocalDataSource.cacheAllTasks(tKey, tTasks));
      });

      test(
          "Should return server failure when call to remote data source is unsuccessful",
          () async {
        when(mockRemoteDataSource.getAllTasks()).thenThrow(ServerException());

        final result = await repository.getAllTasks();
        verify(mockRemoteDataSource.getAllTasks());
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group("When the device is offline", () {

      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("Should return all locally cached tasks if there is cached tasks",
          () async {
        when(mockLocalDataSource.getAllTasks(tKey))
            .thenAnswer((_) async => tTasks);

        final result = await repository.getAllTasks();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAllTasks(tKey));
        expect(result, equals(Right(tTasks)));
      });

      test("Should return CachedFailure if there is no cached task", () async {
        when(mockLocalDataSource.getAllTasks(tKey)).thenThrow(CacheException());

        final result = await repository.getAllTasks();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAllTasks(tKey));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('setDate', () {
    const tIndex = 1;
    const tDueDate = "2023-01-01";
    const tKey = "task key";
    final tTaskModel = TaskModel(
      id: "1",
      name: "Task 1",
      duedate: "2023-01-01",
      description: "repository implementation test",
      isCompleted: false,
    );

    test("Should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.setDate(tIndex, tDueDate))
          .thenAnswer((_) async => tTaskModel);
      repository.setDate(tIndex, tDueDate);
      verify(mockNetworkInfo.isConnected);
    });

    group("When device online", () {

      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          "should return the task when call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.setDate(tIndex, tDueDate))
            .thenAnswer((_) async => tTaskModel);
        final result = await repository.setDate(tIndex, tDueDate);
        verify(mockRemoteDataSource.setDate(tIndex, tDueDate));
        expect(result, equals(Right(tTaskModel)));
      });

      test(
          "Should cache the task when call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.setDate(tIndex, tDueDate))
            .thenAnswer((_) async => tTaskModel);

        await repository.setDate(tIndex, tDueDate);
        verify(mockRemoteDataSource.setDate(tIndex, tDueDate));
        verify(mockLocalDataSource.cacheTask(tTaskModel));
      });

      test(
          "Should return server failure when call to remote data source is unsuccessful",
          () async {
        when(mockRemoteDataSource.setDate(tIndex, tDueDate))
            .thenThrow(ServerException());

        final result = await repository.setDate(tIndex, tDueDate);
        verify(mockRemoteDataSource.setDate(tIndex, tDueDate));
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group("When the device is offline", () {

      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test("Should return last locally cached task if there is cached task",
          () async {
        when(mockLocalDataSource.getLastTask(tKey))
            .thenAnswer((_) async => tTaskModel);

        final result = await repository.setDate(tIndex, tDueDate);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTask(tKey));
        expect(result, equals(Right(tTaskModel)));
      });

      test("Should return CachedFailure if there is no cached task", () async {
        when(mockLocalDataSource.getLastTask(tKey)).thenThrow(CacheException());

        final result = await repository.setDate(tIndex, tDueDate);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTask(tKey));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
