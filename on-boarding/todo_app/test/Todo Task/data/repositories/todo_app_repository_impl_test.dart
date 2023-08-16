import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_local_data_source.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_remote_data_source.dart';
import 'package:todo_app/Todo%20Task/data/models/task_model.dart';
import 'package:todo_app/Todo%20Task/data/repositories/todo_app_repository_impl.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/core/error/exceptions.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/platform/network_info.dart';

class MockRemoteDataSource extends Mock implements TodoTaskRemoteDataSource {}

class MockLocalDataSource extends Mock implements TodoTaskLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late TodoAppRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
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

    test("Should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repository.addTask(tTaskEntity);
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          "should return create new task when call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.addTask(tTaskModel))
            .thenAnswer((_) async => tTaskModel);
        final result = await repository.addTask(tTaskEntity);
        verify(mockRemoteDataSource.addTask(tTaskEntity));
        expect(result, equals(Right(tTaskModel)));
      });

      test(
          "Should cache the tast when call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.addTask(tTaskEntity))
            .thenAnswer((_) async => tTaskModel);

        await repository.addTask(tTaskEntity);
        verify(mockRemoteDataSource.addTask(tTaskEntity));
        verify(mockLocalDataSource.cacheTask(tTaskModel));
      });

      test(
          "Should return server failure when call to remote data source is unsuccessful",
          () async {
        when(mockRemoteDataSource.addTask(tTaskEntity))
            .thenThrow(ServerException());

        final result = await repository.addTask(tTaskEntity);
        verify(mockRemoteDataSource.addTask(tTaskEntity));
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });

  group('getTask', () {
    const tIndex = 1;
    final tTaskModel = TaskModel(
      id: "1",
      name: "Task 1",
      duedate: "2023-01-01",
      description: "repository implementation test",
      isCompleted: false,
    );

    test("Should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repository.getTask(tIndex);
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
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
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test("Should return last locally cached task if there is cached task",
          () async {
        when(mockLocalDataSource.getLastTask())
            .thenAnswer((_) async => tTaskModel);

        final result = await repository.getTask(tIndex);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTask());
        expect(result, equals(Right(tTaskModel)));
      });

      test("Should return CachedFailure if there is no cached task", () async {
        when(mockLocalDataSource.getLastTask()).thenThrow(CacheException());

        final result = await repository.getTask(tIndex);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTask());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getTask', () {
    final tTasks = <TaskModel>[];

    test("Should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repository.getAllTasks();
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
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
        verify(mockLocalDataSource.cacheAllTasks());
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

    runTestsOffline(() {
      test("Should return all locally cached tasks if there is cached tasks",
          () async {
        when(mockLocalDataSource.getAllTasks()).thenAnswer((_) async => tTasks);

        final result = await repository.getAllTasks();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAllTasks());
        expect(result, equals(Right(tTasks)));
      });

      test("Should return CachedFailure if there is no cached task", () async {
        when(mockLocalDataSource.getAllTasks()).thenThrow(CacheException());

        final result = await repository.getAllTasks();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAllTasks());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('setDate', () {
    const tIndex = 1;
    const tDueDate = "2023-01-01";
    final tTaskModel = TaskModel(
      id: "1",
      name: "Task 1",
      duedate: "2023-01-01",
      description: "repository implementation test",
      isCompleted: false,
    );

    test("Should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repository.setDate(tIndex, tDueDate);
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
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

    runTestsOffline(() {
      test("Should return last locally cached task if there is cached task",
          () async {
        when(mockLocalDataSource.getLastTask())
            .thenAnswer((_) async => tTaskModel);

        final result = await repository.setDate(tIndex, tDueDate);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTask());
        expect(result, equals(Right(tTaskModel)));
      });

      test("Should return CachedFailure if there is no cached task", () async {
        when(mockLocalDataSource.getLastTask()).thenThrow(CacheException());

        final result = await repository.setDate(tIndex, tDueDate);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTask());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
