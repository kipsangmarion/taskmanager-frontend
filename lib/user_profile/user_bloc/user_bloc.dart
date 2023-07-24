import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/models/user_profile/user_profile_model.dart';
import 'package:taskmanager_frontend/user_profile/user_profile_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserProfileRepository userProfileRepository})
      : _userProfileRepository = userProfileRepository,
        super(const UserState._()) {
    on<UserEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            profileStateStatus: ProfileStateStatus.loading,
          ),
        );

        final response = await _userProfileRepository.retrieveCurrentUser();
        emit(
          state.copyWith(
            userModel: response,
            profileStateStatus: ProfileStateStatus.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            profileStateStatus: ProfileStateStatus.failure,
          ),
        );
      }
    });
  }

  final UserProfileRepository _userProfileRepository;
}
