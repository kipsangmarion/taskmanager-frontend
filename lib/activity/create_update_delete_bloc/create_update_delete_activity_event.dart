part of 'create_update_delete_activity_bloc.dart';

abstract class CreateUpdateDeleteActivityEvent extends Equatable {
  const CreateUpdateDeleteActivityEvent();

  @override
  List<Object> get props => [];
}

class CreateActivity extends CreateUpdateDeleteActivityEvent {
  final ActivityModel? activity;

  const CreateActivity(this.activity);
}

class UpdateActivity extends CreateUpdateDeleteActivityEvent {
  final ActivityModel? activity;

  const UpdateActivity(this.activity);
}

class DeleteActivity extends CreateUpdateDeleteActivityEvent {
  final ActivityModel? activity;

  const DeleteActivity(this.activity);
}

class RetrieveIndividualActivity extends CreateUpdateDeleteActivityEvent {
  final int? activity;

  const RetrieveIndividualActivity(this.activity);
}
