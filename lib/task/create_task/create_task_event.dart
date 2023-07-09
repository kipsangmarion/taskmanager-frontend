part of 'create_task_bloc.dart';

abstract class CreateTaskEvent extends Equatable {
  const CreateTaskEvent();

  @override
  List<Object> get props => [];
}

class CreateTask extends CreateTaskEvent {
  const CreateTask(this.task);

  final String? task;
}