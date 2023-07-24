import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/models/user_profile/user_profile_model.dart';
import 'package:taskmanager_frontend/user_profile/user_profile_repository.dart';

part 'create_update_delete_user_profile_event.dart';
part 'create_update_delete_user_profile_state.dart';

class CreateUpdateDeleteUserProfileBloc extends Bloc<CreateUpdateDeleteUserProfileEvent, CreateUpdateDeleteUserProfileState> {
  CreateUpdateDeleteUserProfileBloc({required UserProfileRepository userProfileRepository})
      : _userProfileRepository = userProfileRepository,
        super(CreateUpdateDeleteUserProfileInitial()) {
    on<CreateUserProfile>((event, emit) async{
      // TODO: implement event handler
      try{
        emit.call(CreateUpdateDeleteUserProfileLoading());
        final userProfile = await _userProfileRepository.createUserProfile(userprofile: event.userProfile, file: event.file);
        emit.call(CreateUpdateDeleteUserProfileSuccess(userProfile));
      } catch(e) {
        emit.call(CreateUpdateDeleteUserProfileError(e.toString()));
      }
    });

    on<UpdateUserProfile>((event, emit) async{
      // TODO: implement event handler
      try{
        emit.call(CreateUpdateDeleteUserProfileLoading());
        final userProfile = await _userProfileRepository.updateUserProfile(userprofile: event.userProfile, file: event.file);
        emit.call(CreateUpdateDeleteUserProfileSuccess(userProfile));
      } catch(e) {
        emit.call(CreateUpdateDeleteUserProfileError(e.toString()));
      }
    });

    on<DeleteUserProfile>((event, emit) async {
      try {
        emit.call(CreateUpdateDeleteUserProfileLoading());
        final userProfile = await _userProfileRepository.deleteUserProfile(event.userProfile);
        emit.call(CreateUpdateDeleteUserProfileSuccess(userProfile));
      } catch (e) {
        emit.call(CreateUpdateDeleteUserProfileError(e.toString()));
      }
    });

    on<RetrieveIndividualUserProfile>((event, emit) async {
      try {
        emit.call(CreateUpdateDeleteUserProfileLoading());
        final userProfile = await _userProfileRepository.retrieveCurrentUser();
        emit.call(CreateUpdateDeleteUserProfileSuccess(userProfile));
      } catch (e) {
        emit.call(CreateUpdateDeleteUserProfileError(e.toString()));
      }
    });
  }
  final UserProfileRepository _userProfileRepository;
}
