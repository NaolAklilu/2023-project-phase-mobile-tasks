import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/Todo%20Task/data/models/task_model.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tTaskModel = TaskModel(
    id: "0",
    name: "task",
    duedate: "2023-02-02",
    description: "parsing test",
    isCompleted: true,
  );

  test(
    'should be a subclass of TaskModel entity',
    () async {
      expect(tTaskModel, isA<TaskDomain>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('task.json'));
        // act
        final result = TaskModel.fromJson(jsonMap);
        // assert
        expect(result, tTaskModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tTaskModel.toJson();
        // assert
        final expectedJsonMap = {
          "id": "0",
          "name": "task",
          "duedate": "2023-02-02",
          "description": "parsing test",
          "isCompleted": true
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
