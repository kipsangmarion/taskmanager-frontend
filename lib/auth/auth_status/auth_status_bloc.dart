import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

// used to check user authentication status
class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  AuthStatusBloc() : super(AuthStatusInitial()) {
    on<CheckAuthStatusEvent>((event, emit) async {
      emit.call(AuthStatusLoading());
      //check if shared pref key access token has data
      // store access token to local storage
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access');
      if (accessToken?.isNotEmpty ?? false) {
        emit.call(AuthStatusSuccess());
      } else {
        emit.call(AuthStatusLoggedOut());
      }
    });
  }
}