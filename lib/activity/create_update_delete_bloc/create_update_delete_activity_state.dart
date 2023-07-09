part of 'create_update_delete_activity_bloc.dart';

abstract class CreateUpdateDeleteActivityState extends Equatable {
  const CreateUpdateDeleteActivityState();

  @override
  List<Object> get props => [];
}

class CreateUpdateDeleteActivityInitial extends CreateUpdateDeleteActivityState {}

class CreateUpdateDeleteActivityLoading extends CreateUpdateDeleteActivityState {}

class CreateUpdateDeleteActivitySuccess extends CreateUpdateDeleteActivityState {
  final ActivityModel? activityModel;
  const CreateUpdateDeleteActivitySuccess(this.activityModel);
}

class CreateUpdateDeleteActivityError extends CreateUpdateDeleteActivityState {
  const CreateUpdateDeleteActivityError(this.errorMessage);

  final String? errorMessage;
}
