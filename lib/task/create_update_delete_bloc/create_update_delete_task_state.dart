part of 'create_update_delete_task_bloc.dart';

abstract class CreateUpdateDeleteTaskState extends Equatable {
  const CreateUpdateDeleteTaskState();

  @override
  List<Object> get props => [];
}

class CreateUpdateDeleteTaskInitial extends CreateUpdateDeleteTaskState {}

class CreateUpdateDeleteTaskLoading extends CreateUpdateDeleteTaskState {}

class CreateUpdateDeleteTaskSuccess extends CreateUpdateDeleteTaskState {
  final TaskModel? taskModel;
  const CreateUpdateDeleteTaskSuccess(this.taskModel);
}

class CreateUpdateDeleteTaskError extends CreateUpdateDeleteTaskState {
  const CreateUpdateDeleteTaskError(this.errorMessage);

  final String? errorMessage;
}

