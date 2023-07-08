import 'package:taskmanager_frontend/activity/activity_api.dart';
import 'package:taskmanager_frontend/models/paginated/links.dart';
import 'package:taskmanager_frontend/models/paginated/paginated_model.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';

class ActivityRepository {
  ActivityRepository(this.activityAPis);
  final ActivityAPis activityAPis;

  Future<PaginatedModel<ActivityModel>>? getActivity() async {
    final response = await activityAPis.getActivity();
    return PaginatedModel(
      lastPage: response?['data']['last_page'] as int,
      links: Links.fromJson(response?['data']['links'] as Map<String, dynamic>),
      results: (response?['data']['results'] as List)
          .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<ActivityModel>? createActivity(ActivityModel? activityModel) async {
    final response = await activityAPis.createActivity(activityModel);
    return ActivityModel.fromJson(response?['data'] as Map<String, dynamic>);
  }
}