import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_remote_data_source_impl.dart';
import 'package:todo_app/Todo%20Task/data/models/task_model.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late TodoTaskRemoteDataSourceImp dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TodoTaskRemoteDataSourceImp(client: mockHttpClient);
  });

  group('getTask', () {
    final url = "http://todotask.com/" as Uri;
    const tIndex = 1;
    final tTaskModel = TaskModel.fromJson(json.decode(fixture('task.json')));

    test(
      'should preform a GET request on a URL with index being the endpoint and with application/json header',
      () {
        //arrange
        when(mockHttpClient.get(url, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('task.json'), 200),
        );
        // act
        dataSource.getTask(tIndex);
        // assert
        verify(mockHttpClient.get(
          'http://todotask.com/$tIndex' as Uri,
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test("Should return task when the status code is 200", () async {
      when(mockHttpClient.get(url, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(
          fixture('task.json'),
          200,
        ),
      );

      final result = dataSource.getTask(tIndex);

      expect(result, equals(tTaskModel));
    });
  });
}
