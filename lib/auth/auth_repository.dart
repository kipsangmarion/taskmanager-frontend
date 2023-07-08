import 'package:taskmanager_frontend/auth/auth_api.dart';
import 'package:taskmanager_frontend/models/login/login_model.dart';
import 'package:taskmanager_frontend/models/user/auth_model.dart';

class AuthRepository {
  AuthRepository(this.authAPis);
  final AuthAPis authAPis;

  Future<AuthModel>? registerUser(
      AuthModel? authModel,
      ) async {
    final response = await authAPis.registerUser(authModel);
    return AuthModel.fromJson(
      response?['data'] as Map<String, dynamic>,
    );
  }

  Future<LoginModel>? loginUser(
      AuthModel? authModel,
      ) async {
    final response = await authAPis.loginUser(authModel);
    return LoginModel.fromJson(
      response?['data'] as Map<String, dynamic>,
    );
  }
}