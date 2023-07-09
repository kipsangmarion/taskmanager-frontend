part of 'create_update_delete_user_profile_bloc.dart';

abstract class CreateUpdateDeleteUserProfileEvent extends Equatable {
  const CreateUpdateDeleteUserProfileEvent();

  @override
  List<Object> get props => [];
}

class CreateUserProfile extends CreateUpdateDeleteUserProfileEvent {
  final UserProfileModel? userProfileModel;
  final File? file;

  const CreateUserProfile(this.userProfileModel, this.file);
}

class UpdateUserProfile extends CreateUpdateDeleteUserProfileEvent {
  final UserProfileModel? userProfileModel;
  final File? file;

  const UpdateUserProfile(this.userProfileModel, this.file);
}

class DeleteUserProfile extends CreateUpdateDeleteUserProfileEvent {
  final UserProfileModel? userProfileModel;
  final File? file;

  const DeleteUserProfile(this.userProfileModel, this.file);
}

class RetrieveIndividualUserProfile extends CreateUpdateDeleteUserProfileEvent {
  final UserProfileModel? userProfileModel;
  final File? file;

  const RetrieveIndividualUserProfile(this.userProfileModel, this.file);
}