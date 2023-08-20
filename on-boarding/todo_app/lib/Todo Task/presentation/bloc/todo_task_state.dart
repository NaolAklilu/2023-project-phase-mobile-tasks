part of 'todo_task_bloc.dart';

@immutable
abstract class TodoTaskState extends Equatable {
  const TodoTaskState();

  @override
  List<Object> get props => [];
}

class InitialState extends TodoTaskState {}

class LoadingState extends TodoTaskState {}

class LoadedTaskState extends TodoTaskState {
  final TaskDomain taskDomain;

  LoadedTaskState({required this.taskDomain});
}

class LoadedAllTasksState extends TodoTaskState {
  final List<TaskDomain> tasks;

  LoadedAllTasksState({required this.tasks});
}

class ErrorState extends TodoTaskState {
  final String message;

  ErrorState({required this.message});
}
