import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_local_data_source_impl.dart';
import 'package:todo_app/Todo%20Task/data/models/task_model.dart';
import 'package:todo_app/core/error/exceptions.dart';

import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late TodoTaskLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = TodoTaskLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastTask', () {
    const tKey = "task key";
    final tTaskModel = TaskModel.fromJson(json.decode(fixture('task.json')));

    test(
      'should return Task from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'))
            .thenReturn(fixture('task.json'));
        // act
        final result = await dataSource.getLastTask(tKey);
        // assert
        verify(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));
        expect(result, equals(tTaskModel));
      },
    );

    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(mockSharedPreferences.getString(tKey)).thenReturn(null);
      // act
      final call = dataSource.getLastTask;
      // assert
      expect(() => call(tKey), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheTask', () {
    const tKey = "task key";
    final tTaskModel = TaskModel.fromJson(json.decode(fixture('task.json')));

    test('should call SharedPreferences to cache the data', () {
      // act
      dataSource.cacheTask(tKey, tTaskModel);
      // assert
      final expectedJsonString = json.encode(tTaskModel.toJson());
      verify(mockSharedPreferences.setString(
        CACHED_TASK,
        expectedJsonString,
      ));
    });
  });

  group('cacheAllTasks', () {
    const tKey = "task key";
    final tTaskModel = TaskModel.fromJson(json.decode(fixture('task.json')));
    final tTasks = <TaskModel>[tTaskModel];

    test('should call SharedPreferences to cache all the tasks', () {
      // act
      dataSource.cacheAllTasks(tKey, tTasks);
      // assert
      final expectedJsonString = json.encode(tTasks[0].toJson());
      verify(mockSharedPreferences.setString(
        CACHED_TASK,
        expectedJsonString,
      ));
    });
  });
}
