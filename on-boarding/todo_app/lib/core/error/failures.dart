import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure implements Exception {}

class CacheFailure implements Exception {}
