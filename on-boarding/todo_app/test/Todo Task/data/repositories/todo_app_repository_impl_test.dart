
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_local_data_source.dart';
import 'package:todo_app/Todo%20Task/data/datasources/todo_task_remote_data_source.dart';
import 'package:todo_app/Todo%20Task/data/repositories/todo_app_repository_impl.dart';
import 'package:todo_app/core/platform/network_info.dart';

class MockRemoteDataSource extends Mock
    implements TodoTaskRemoteDataSource {}

class MockLocalDataSource extends Mock implements TodoTaskLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  TodoAppRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

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
}