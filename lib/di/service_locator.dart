import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:taskmanager_frontend/auth/auth_api.dart';
import 'package:taskmanager_frontend/auth/auth_repository.dart';
import 'package:taskmanager_frontend/task/task_api.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';
import 'package:taskmanager_frontend/activity/activity_api.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';
import 'package:taskmanager_frontend/comment/comment_api.dart';
import 'package:taskmanager_frontend/comment/comment_repository.dart';
import 'package:taskmanager_frontend/user_profile/user_profile_api.dart';
import 'package:taskmanager_frontend/user_profile/user_profile_repository.dart';
import 'package:taskmanager_frontend/network/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt
    ..registerSingleton(Dio())
    ..registerSingleton(DioClient(getIt<Dio>()))
    ..registerSingleton(AuthAPis(getIt<DioClient>()))
    ..registerSingleton(AuthRepository(getIt.get<AuthAPis>()))
    ..registerSingleton(TaskAPis(getIt<DioClient>()))
    ..registerSingleton(TaskRepository(getIt.get<TaskAPis>()))
    ..registerSingleton(ActivityAPis(getIt<DioClient>()))
    ..registerSingleton(ActivityRepository(getIt.get<ActivityAPis>()))
    ..registerSingleton(CommentAPis(getIt<DioClient>()))
    ..registerSingleton(CommentRepository(getIt.get<CommentAPis>()))
    ..registerSingleton(UserProfileAPis(getIt<DioClient>()))
    ..registerSingleton(UserProfileRepository(getIt.get<UserProfileAPis>()));
}