part of 'retrieve_activities_bloc.dart';

abstract class RetrieveActivitiesEvent extends Equatable {
  const RetrieveActivitiesEvent();

  @override
  List<Object> get props => [];
}

class RetrieveUserActivities extends RetrieveActivitiesEvent{}