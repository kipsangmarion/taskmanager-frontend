import 'package:taskmanager_frontend/models/activity/activity_model.dart';
import 'package:taskmanager_frontend/network/api/endpoints.dart';
import 'package:taskmanager_frontend/network/dio_client.dart';

class ActivityAPis {
  ActivityAPis(this.dioClient);

  final DioClient dioClient;

  Future<Map<String, dynamic>?> createActivity(
      ActivityModel? activityModel,
      ) async {
    final response = await dioClient.post(Endpoints.activity, data: activityModel?.toJson());
    return response;
  }

  Future<Map<String, dynamic>?> getActivity(

      ) async {
    final response = await dioClient.get(
      Endpoints.activity,
    );
    return response;
  }

  Future<Map<String, dynamic>?> retrieveSpecificActivity(
      int? activity,
      ) async {
    final response = await dioClient.get(
      '${Endpoints.activity}$activity',
    );
    return response;
  }
}