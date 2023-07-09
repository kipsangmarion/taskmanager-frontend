part of 'create_update_delete_task_bloc.dart';

abstract class CreateUpdateDeleteTaskEvent extends Equatable {
  const CreateUpdateDeleteTaskEvent();

  @override
  List<Object> get props => [];
}

class CreateTask extends CreateUpdateDeleteTaskEvent {
  final TaskModel? task;

  const CreateTask(this.task);
}

class UpdateTask extends CreateUpdateDeleteTaskEvent {
  final TaskModel? task;

  const UpdateTask(this.task);
}

class DeleteTask extends CreateUpdateDeleteTaskEvent {
  final TaskModel? task;

  const DeleteTask(this.task);
}

class RetrieveIndividualTask extends CreateUpdateDeleteTaskEvent {
  final int? task;

  const RetrieveIndividualTask(this.task);
}