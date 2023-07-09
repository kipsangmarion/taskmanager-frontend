import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(CreateTaskInitial()) {
    on<CreateTask>((event, emit) async {
      try {
        emit.call(CreateTaskLoading());
        await _taskRepository.createTask(event.task as TaskModel?);
        emit.call(CreateTaskSuccess());
      } catch (e) {
        emit.call(CreateTaskError(e.toString()));
      }
    });
  }
  final TaskRepository _taskRepository;
}