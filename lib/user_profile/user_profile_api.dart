import 'dart:io';

import 'package:dio/dio.dart';
import 'package:taskmanager_frontend/models/user_profile/user_profile_model.dart';
import 'package:taskmanager_frontend/network/api/endpoints.dart';
import 'package:taskmanager_frontend/network/dio_client.dart';

class UserProfileAPis {
  UserProfileAPis(this.dioClient);

  final DioClient dioClient;

  Future<Map<String, dynamic>?> createUserProfile({
    UserProfileModel? userProfileModel,
    File? file,
  }) async {
    final response = await dioClient.post(Endpoints.userprofile,
        data: FormData.fromMap({
          'id': userProfileModel?.id,
          'user': userProfileModel?.user,
          'intro': userProfileModel?.intro,
          if (file != null) 'image': await MultipartFile.fromFile(file.path),
        }));
    return response;
  }

  Future<Map<String, dynamic>?> getUserProfiles() async {
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

  Future<Map<String, dynamic>?> updateUserProfile({
    UserProfileModel? userProfileModel,
    File? file,
  }) async {
    final response = await dioClient.put('${Endpoints.userprofile}${userProfileModel?.id}',
        data: FormData.fromMap({
          'id': userProfileModel?.id,
          'user': userProfileModel?.user,
          'intro': userProfileModel?.intro,
          if (file != null) 'image': await MultipartFile.fromFile(file.path),
        }));
    return response;
  }

  Future<Map<String, dynamic>?> deleteUserProfile(
    UserProfileModel? userProfileModel
  ) async {
    final response = await dioClient.delete('${Endpoints.userprofile}${userProfileModel?.id}',
        data: userProfileModel?.toJson());
    return response;
  }
}