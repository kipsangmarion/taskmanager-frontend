import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';

part 'create_update_delete_activity_event.dart';
part 'create_update_delete_activity_state.dart';

class CreateUpdateDeleteActivityBloc extends Bloc<CreateUpdateDeleteActivityEvent, CreateUpdateDeleteActivityState> {
  CreateUpdateDeleteActivityBloc({required ActivityRepository activityRepository})
      : _activityRepository = activityRepository,
        super(CreateUpdateDeleteActivityInitial()) {
    on<CreateActivity>((event, emit) async {
      try {
        emit.call(CreateUpdateDeleteActivityLoading());
        final activity = await _activityRepository.createActivity(event.activity);
        emit.call(CreateUpdateDeleteActivitySuccess(activity));
      } catch (e) {
        emit.call(CreateUpdateDeleteActivityError(e.toString()));
      }
    });

    on<UpdateActivity>((event, emit) async {
      try {
//  //TODO update individual task given taskmodel
        emit.call(CreateUpdateDeleteActivityLoading());
        final activity = await _activityRepository.updateActivity(event.activity);
        emit.call(CreateUpdateDeleteActivitySuccess(activity));
      } catch (e) {
        emit.call(CreateUpdateDeleteActivityError(e.toString()));
      }
    });

    on<DeleteActivity>((event, emit) async {
      try {
        emit.call(CreateUpdateDeleteActivityLoading());
        //TODO delete individual task given taskmodel
        final activity = await _activityRepository.deleteActivity(event.activity);
        emit.call(CreateUpdateDeleteActivitySuccess(activity));
      } catch (e) {
        emit.call(CreateUpdateDeleteActivityError(e.toString()));
      }
    });

    on<RetrieveIndividualActivity>((event, emit) async {
      try {
        emit.call(CreateUpdateDeleteActivityLoading());
        //TODO get retrieve individual task given id
        final activity = await _activityRepository.retrieveSpecificActivity(event.activity);
        emit.call(CreateUpdateDeleteActivitySuccess(activity));
      } catch (e) {
        emit.call(CreateUpdateDeleteActivityError(e.toString()));
      }
    });
  }
  final ActivityRepository _activityRepository;
}