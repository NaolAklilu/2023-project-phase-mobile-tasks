import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/Todo%20Task/domain/entities/task_domain.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/create_task.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/get_all_tasks.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/get_task.dart';
import 'package:todo_app/Todo%20Task/domain/usecases/mark_completion.dart';

import '../../../core/error/failures.dart';
import '../../domain/usecases/set_date.dart';

part 'todo_task_event.dart';
part 'todo_task_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class TodoTaskBloc extends Bloc<TodoTaskEvent, TodoTaskState> {
  final GetTask getTask;
  final GetAllTasks getAllTasks;
  final CreateTask createTask;
  final SetDate setDate;
  final MarkCompletion markCompletion;

  TodoTaskBloc({
    required this.createTask,
    required this.getTask,
    required this.getAllTasks,
    required this.markCompletion,
    required this.setDate,
  }) : super(InitialState()) {
    on<GetTaskEvent>(_onGetTaskEvent);
    on<CreateTaskEvent>(_onCreateTaskEvent);
    on<GetAllTasksEvent>(_onGetAllTasksEvent);
    on<MarkCompletionEvent>(_onMarkCompletionEvent);
    on<SetDateEvent>(_onSetDateEvent);
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  FutureOr<void> _onGetTaskEvent(
      GetTaskEvent event, Emitter<TodoTaskState> emit) async {
    emit(LoadingState());
    final resultOrError = await getTask(GetTaskParams(index: event.index));

    resultOrError.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (task) => emit(LoadedTaskState(taskDomain: task)));
  }

  FutureOr<void> _onCreateTaskEvent(
      CreateTaskEvent event, Emitter<TodoTaskState> emit) async {
    emit(LoadingState());
    final errorOrResult =
        await createTask(CreateTaskParams(task: event.taskEntity));

    errorOrResult.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (task) => emit(LoadedTaskState(taskDomain: task)));
  }

  FutureOr<void> _onGetAllTasksEvent(
      GetAllTasksEvent event, Emitter<TodoTaskState> emit) async {
    emit(LoadingState());
    final errorOrResult = await getAllTasks(NoParams());

    errorOrResult.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (tasks) => emit(LoadedAllTasksState(tasks: tasks)));
  }

  FutureOr<void> _onMarkCompletionEvent(
      MarkCompletionEvent event, Emitter<TodoTaskState> emit) async {
    emit(LoadingState());
    final errorOrResult =
        await markCompletion(MarkCompletionParams(index: event.index));

    errorOrResult.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (task) => emit(LoadedTaskState(taskDomain: task)));
  }

  FutureOr<void> _onSetDateEvent(
      SetDateEvent event, Emitter<TodoTaskState> emit) async {
    emit(LoadingState());
    final failureOrResult =
        await setDate(SetDateParams(index: event.index, dateTime: event.date));

    failureOrResult.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (task) => emit(LoadedTaskState(taskDomain: task)));
  }
}
