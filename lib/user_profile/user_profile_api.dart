import 'dart:io';

import 'package:taskmanager_frontend/models/user_profile/user_profile_model.dart';
import 'package:taskmanager_frontend/network/api/endpoints.dart';
import 'package:taskmanager_frontend/network/dio_client.dart';

class UserProfileAPis {
  UserProfileAPis(this.dioClient);

  final DioClient dioClient;

  Future<Map<String, dynamic>?> createUserProfile(
      int? userprofile,
      UserProfileModel? userProfileModel,
      File file,
      ) async {
    final response = await dioClient.post('${Endpoints.userprofile}$userprofile', data: FormData.fromMap({
      'username'
    }));
    return response;
  }

  Future<Map<String, dynamic>?> getUserProfile(

      ) async {
    final response = await dioClient.get(
      Endpoints.userprofile,
    );
    return response;
  }

  Future<Map<String, dynamic>?> retrieveSpecificUserProfile(
      int? userprofile,
      ) async {
    final response = await dioClient.get(
      '${Endpoints.userprofile}$userprofile',
    );
    return response;
  }
}