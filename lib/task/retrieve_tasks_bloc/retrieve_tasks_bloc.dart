import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';

import '../../models/task/task_model.dart';

part 'retrieve_tasks_event.dart';
part 'retrieve_tasks_state.dart';

class RetrieveTasksBloc extends Bloc<RetrieveTasksEvent, RetrieveTasksState> {
  RetrieveTasksBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(RetrieveTasksInitial()) {
    on<RetrieveUserTasks>((event, emit) async {
      try {
        emit.call(RetrieveTasksLoading());
        final tasks = await _taskRepository.getTasks(event.tag);
        emit.call(RetrieveTasksSuccess(tasks?.results));
      } on DioException catch (e) {
        emit.call(RetrieveTasksError(e.toString()));
      } catch (e) {
        emit.call(RetrieveTasksError(e.toString()));
      }
    });
  }
  final TaskRepository _taskRepository;
}
