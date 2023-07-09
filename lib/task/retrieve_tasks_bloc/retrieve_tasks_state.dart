part of 'retrieve_tasks_bloc.dart';

abstract class RetrieveTasksState extends Equatable {
  const RetrieveTasksState();

  @override
  List<Object> get props => [];
}

class RetrieveTasksInitial extends RetrieveTasksState {
}

class RetrieveTasksLoading extends RetrieveTasksState {
}

class RetrieveTasksSuccess extends RetrieveTasksState {
  final List<TaskModel>? taskModel;

  const RetrieveTasksSuccess(this.taskModel);

}

class RetrieveTasksError extends RetrieveTasksState {
  const RetrieveTasksError(this.errorMessage);

  final String? errorMessage;
}
