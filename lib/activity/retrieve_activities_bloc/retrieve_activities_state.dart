part of 'retrieve_activities_bloc.dart';

abstract class RetrieveActivitiesState extends Equatable {
  const RetrieveActivitiesState();

  @override
  List<Object> get props => [];
}

class RetrieveActivitiesInitial extends RetrieveActivitiesState {
}

class RetrieveActivitiesLoading extends RetrieveActivitiesState {
}

class RetrieveActivitiesEmpty extends RetrieveActivitiesState {}
class RetrieveActivitiesSuccess extends RetrieveActivitiesState {
  final List<ActivityModel>? activityModel;

  const RetrieveActivitiesSuccess(this.activityModel);
}

class RetrieveActivitiesError extends RetrieveActivitiesState {
  const RetrieveActivitiesError(this.errorMessage);

  final String? errorMessage;
}
