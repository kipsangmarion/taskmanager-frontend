import 'dart:io';

import 'package:taskmanager_frontend/user_profile/user_profile_api.dart';
import 'package:taskmanager_frontend/models/paginated/links.dart';
import 'package:taskmanager_frontend/models/paginated/paginated_model.dart';
import 'package:taskmanager_frontend/models/user_profile/user_profile_model.dart';

class UserProfileRepository {
  UserProfileRepository(this.userprofileAPis);
  final UserProfileAPis userprofileAPis;

  Future<PaginatedModel<UserProfileModel>>? getUserProfile() async {
    final response = await userprofileAPis.getUserProfile();
    return PaginatedModel(
      lastPage: response?['data']['last_page'] as int,
      links: Links.fromJson(response?['data']['links'] as Map<String, dynamic>),
      results: (response?['data']['results'] as List)
          .map((e) => UserProfileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<UserProfileModel>? createUserProfile({
    UserProfileModel? userprofile,
    required File file,
  }) async {
    final response = await userprofileAPis.createUserProfile(
      userProfileModel: userprofile,
      file: file,
    );
    return UserProfileModel.fromJson(response?['data'] as Map<String, dynamic>);
  }
}