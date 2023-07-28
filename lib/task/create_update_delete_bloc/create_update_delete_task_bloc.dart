import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';

part 'create_update_delete_task_event.dart';
part 'create_update_delete_task_state.dart';

class CreateUpdateDeleteTaskBloc extends Bloc<CreateUpdateDeleteTaskEvent, CreateUpdateDeleteTaskState> {
  CreateUpdateDeleteTaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(CreateUpdateDeleteTaskInitial()) {
    on<CreateTask>((event, emit) async {
      try {
        emit.call(CreateUpdateDeleteTaskLoading());
        final task = await _taskRepository.createTask(event.task);
        emit.call(CreateUpdateDeleteTaskSuccess(task));
      } catch (e) {
        emit.call(CreateUpdateDeleteTaskError(e.toString()));
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
//  //TODO update individual task given taskmodel
        emit.call(CreateUpdateDeleteTaskLoading());
        final task = await _taskRepository.updateTask(event.task);
        emit.call(CreateUpdateDeleteTaskSuccess(task));
      } catch (e) {
        emit.call(CreateUpdateDeleteTaskError(e.toString()));
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        emit.call(CreateUpdateDeleteTaskLoading());
        //TODO delete individual task given taskmodel
        final task = await _taskRepository.deleteTask(event.task);
        emit.call(CreateUpdateDeleteTaskSuccess(task));
      } catch (e) {
        emit.call(CreateUpdateDeleteTaskError(e.toString()));
      }
    });

    on<RetrieveIndividualTask>((event, emit) async {
      try {
        emit.call(CreateUpdateDeleteTaskLoading());
        //TODO get retrieve individual task given id
        final task = await _taskRepository.retrieveSpecificTask(event.task);
        emit.call(CreateUpdateDeleteTaskSuccess(task));
      } catch (e) {
        emit.call(CreateUpdateDeleteTaskError(e.toString()));
      }
    });
  }
  final TaskRepository _taskRepository;
}