part of 'retrieve_tasks_bloc.dart';

abstract class RetrieveTasksEvent extends Equatable {
  const RetrieveTasksEvent();

  @override
  List<Object> get props => [];
}

class RetrieveUserTasks extends RetrieveTasksEvent{}
