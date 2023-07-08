import 'package:taskmanager_frontend/models/user/auth_model.dart';
import 'package:taskmanager_frontend/network/api/endpoints.dart';
import 'package:taskmanager_frontend/network/dio_client.dart';

class AuthAPis {
  AuthAPis(this.dioClient);

  final DioClient dioClient;

  Future<Map<String, dynamic>?> registerUser(
      AuthModel? authModel,
      ) async {
    final response =
    await dioClient.post(Endpoints.register, data: authModel?.toJson());
    return response;
  }

  Future<Map<String, dynamic>?> loginUser(
      AuthModel? authModel,
      ) async {
    final response =
    await dioClient.post(Endpoints.login, data: authModel?.toJson());
    return response;
  }
}