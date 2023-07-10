part of 'create_update_delete_user_profile_bloc.dart';

abstract class CreateUpdateDeleteUserProfileEvent extends Equatable {
  const CreateUpdateDeleteUserProfileEvent();

  @override
  List<Object> get props => [];
}

class CreateUserProfile extends CreateUpdateDeleteUserProfileEvent {
  final UserProfileModel? userProfile;
  final File file;

  const CreateUserProfile({this.userProfile, required this.file});
}

class UpdateUserProfile extends CreateUpdateDeleteUserProfileEvent {
  final UserProfileModel? userProfile;
  final File file;

  const UpdateUserProfile({this.userProfile, required this.file});
}

class DeleteUserProfile extends CreateUpdateDeleteUserProfileEvent {
  final UserProfileModel? userProfile;

  const DeleteUserProfile(this.userProfile);
}

class RetrieveIndividualUserProfile extends CreateUpdateDeleteUserProfileEvent {
  final int? userProfile;

  const RetrieveIndividualUserProfile(this.userProfile);
}