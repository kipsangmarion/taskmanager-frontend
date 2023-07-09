part of 'create_task_bloc.dart';

abstract class CreateTaskState extends Equatable {
  const CreateTaskState();

  @override
  List<Object> get props => [];
}

class CreateTaskInitial extends CreateTaskState {}

class CreateTaskLoading extends CreateTaskState {}

class CreateTaskSuccess extends CreateTaskState {}

class CreateTaskError extends CreateTaskState {
  const CreateTaskError(this.errorMessage);

  final String? errorMessage;
}