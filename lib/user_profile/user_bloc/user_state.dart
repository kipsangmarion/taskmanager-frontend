part of 'user_bloc.dart';

enum ProfileStateStatus { loading, success, failure, initial, updated }

class UserState extends Equatable {
  const UserState._({
    this.message,
    this.profileStateStatus = ProfileStateStatus.loading,
    this.userModel,
  });
  final UserProfileModel? userModel;
  final ProfileStateStatus profileStateStatus;
  final String? message;

  @override
  List<Object?> get props => [message, profileStateStatus, userModel];

  Map<String, dynamic>? toJson() {
    return {
      'userModel': userModel?.toJson(),
      'profileStateStatus': profileStateStatus,
    };
  }

  UserState copyWith({
    UserProfileModel? userModel,
    ProfileStateStatus? profileStateStatus,
    String? message,
  }) {
    return UserState._(
      message: message ?? this.message,
      userModel: userModel ?? this.userModel,
      profileStateStatus: profileStateStatus ?? this.profileStateStatus,
    );
  }
}
