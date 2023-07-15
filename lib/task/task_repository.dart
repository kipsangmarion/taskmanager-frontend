import 'package:taskmanager_frontend/task/task_api.dart';
import 'package:taskmanager_frontend/models/paginated/links.dart';
import 'package:taskmanager_frontend/models/paginated/paginated_model.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';

class TaskRepository {
  TaskRepository(this.taskAPis);
  final TaskAPis taskAPis;

  Future<PaginatedModel<TaskModel>>? getTasks(String? tag) async {
    final response = await taskAPis.getTasks(tag);
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

  Future<TaskModel>? updateTask(TaskModel? taskModel) async {
    final response = await taskAPis.updateTask(taskModel);
    return TaskModel.fromJson(response?['data'] as Map<String, dynamic>);
  }

  Future<TaskModel>? deleteTask(TaskModel? taskModel) async {
    final response = await taskAPis.deleteTask(taskModel);
    return TaskModel.fromJson(response?['data'] as Map<String, dynamic>);
  }

  Future<TaskModel>? retrieveSpecificTask(int? task) async {
    final response = await taskAPis.retrieveSpecificTask(task);
    return TaskModel.fromJson(response?['data'] as Map<String, dynamic>);
  }
}