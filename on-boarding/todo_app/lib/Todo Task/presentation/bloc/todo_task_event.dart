part of 'todo_task_bloc.dart';

@immutable
abstract class TodoTaskEvent extends Equatable {
  const TodoTaskEvent();

  @override
  List<Object> get props => [];
}

class CreateTaskEvent extends TodoTaskEvent {
  final TaskDomain taskEntity;

  CreateTaskEvent({required this.taskEntity});
}

class GetTaskEvent extends TodoTaskEvent {
  final int index;

  GetTaskEvent({required this.index});
}

class GetAllTasksEvent extends TodoTaskEvent {}

class UpdateTaskEvent extends TodoTaskEvent {
  final int index;

  UpdateTaskEvent({required this.index});
}

class SetDateEvent extends TodoTaskEvent {
  final int index;
  final String date;

  SetDateEvent({required this.index, required this.date});
}

class MarkCompletionEvent extends TodoTaskEvent {
  final int index;

  MarkCompletionEvent({required this.index});
}
