import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';
import 'package:taskmanager_frontend/models/user_profile/user_profile_model.dart';

part 'create_update_delete_user_profile_event.dart';
part 'create_update_delete_user_profile_state.dart';

class CreateUpdateDeleteUserProfileBloc extends Bloc<CreateUpdateDeleteUserProfileEvent, CreateUpdateDeleteUserProfileState> {
  CreateUpdateDeleteUserProfileBloc() : super(CreateUpdateDeleteUserProfileInitial()) {
    on<CreateUpdateDeleteUserProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
