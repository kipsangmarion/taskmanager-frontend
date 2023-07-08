import 'package:taskmanager_frontend/task/task_api.dart';
import 'package:taskmanager_frontend/models/paginated/links.dart';
import 'package:taskmanager_frontend/models/paginated/paginated_model.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';

class TaskRepository {
  TaskRepository(this.taskAPis);
  final TaskAPis taskAPis;

  Future<PaginatedModel<TaskModel>>? getTask() async {
    final response = await taskAPis.getTask();
    return PaginatedModel(
      lastPage: response?['data']['last_page'] as int,
      links: Links.fromJson(response?['data']['links'] as Map<String, dynamic>),
      results: (response?['data']['results'] as List)
          .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<TaskModel>? createTask(TaskModel? taskModel) async {
    final response = await taskAPis.createTask(taskModel);
    return TaskModel.fromJson(response?['data'] as Map<String, dynamic>);
  }
}