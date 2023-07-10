part of 'create_update_delete_user_profile_bloc.dart';

abstract class CreateUpdateDeleteUserProfileState extends Equatable {
  const CreateUpdateDeleteUserProfileState();

  @override
  List<Object> get props => [];
}

class CreateUpdateDeleteUserProfileInitial extends CreateUpdateDeleteUserProfileState {
}

class CreateUpdateDeleteUserProfileLoading extends CreateUpdateDeleteUserProfileState {
}

class CreateUpdateDeleteUserProfileSuccess extends CreateUpdateDeleteUserProfileState {
  final UserProfileModel? userProfileModel;

  const CreateUpdateDeleteUserProfileSuccess(this.userProfileModel);
}

class CreateUpdateDeleteUserProfileError extends CreateUpdateDeleteUserProfileState {
  const CreateUpdateDeleteUserProfileError(this.errorMessage);

  final String? errorMessage;
}
