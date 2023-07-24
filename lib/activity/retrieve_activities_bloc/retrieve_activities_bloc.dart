import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';

import '../../models/activity/activity_model.dart';

part 'retrieve_activities_event.dart';
part 'retrieve_activities_state.dart';

class RetrieveActivitiesBloc
    extends Bloc<RetrieveActivitiesEvent, RetrieveActivitiesState> {
  RetrieveActivitiesBloc({required ActivityRepository activityRepository})
      : _activityRepository = activityRepository,
        super(RetrieveActivitiesInitial()) {
    on<RetrieveUserActivities>((event, emit) async {
      try {
        emit.call(RetrieveActivitiesLoading());
        final activities =
            await _activityRepository.getActivities(task: event.task);
        if (activities?.results?.isEmpty ?? false) {
          emit.call(RetrieveActivitiesEmpty());
        } else {
          emit.call(RetrieveActivitiesSuccess(activities?.results));
        }
      } on DioException catch (e) {
        emit.call(RetrieveActivitiesError(e.toString()));
      } catch (e) {
        emit.call(RetrieveActivitiesError(e.toString()));
      }
    });
  }
  final ActivityRepository _activityRepository;
}
