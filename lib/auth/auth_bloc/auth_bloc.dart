import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/auth/auth_repository.dart';
import 'package:taskmanager_frontend/models/user/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// used to auth , register, logout user
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      try {
        emit.call(AuthLoading());
        await _authRepository.registerUser(event.authModel);
        // store access token to local storage
        emit.call(AuthSuccess());
      } on DioException catch (e) {
        //ideally here you return a generic error and log the error to your analytics
        emit.call(AuthError(e.message.toString()));
      } catch (e) {
        //ideally here you return a generic error and log the error to your analytics
        emit.call(AuthError(e.toString()));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      try {
        emit.call(AuthLoading());
        final response = await _authRepository.loginUser(event.authModel);
        // store access token to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access', response?.access ?? '');
        await prefs.setString('refresh', response?.refresh ?? '');

        emit.call(AuthSuccess());
      } on DioException catch (e) {
        //ideally here you return a generic error and log the error to your analytics
        emit.call(AuthError(e.message.toString()));
      } catch (e) {
        //ideally here you return a generic error and log the error to your analytics
        emit.call(AuthError(e.toString()));
      }
    });
    on<LogoutUserEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit.call(AuthLogoutSuccess());
    });
  }
  final AuthRepository _authRepository;
}
