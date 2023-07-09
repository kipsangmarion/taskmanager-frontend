import 'package:taskmanager_frontend/models/task/task_model.dart';
import 'package:taskmanager_frontend/network/api/endpoints.dart';
import 'package:taskmanager_frontend/network/dio_client.dart';

class TaskAPis {
  TaskAPis(this.dioClient);

  final DioClient dioClient;

  Future<Map<String, dynamic>?> createTask(
      TaskModel? taskModel,
      ) async {
    final response = await dioClient.post(Endpoints.task, data: taskModel?.toJson());
    return response;
  }

  Future<Map<String, dynamic>?> getTasks(

      ) async {
    final response = await dioClient.get(
      Endpoints.task,
    );
    return response;
  }

  Future<Map<String, dynamic>?> retrieveSpecificTask(
      int? task,
      ) async {
    final response = await dioClient.get(
      '${Endpoints.task}$task',
    );
    return response;
  }

  Future<Map<String, dynamic>?> updateTask(
      TaskModel? taskModel,
      ) async {
    final response = await dioClient.put('${Endpoints.task}${taskModel?.id}', data: taskModel?.toJson());
    return response;
  }

  Future<Map<String, dynamic>?> deleteTask(
      TaskModel? taskModel,
      ) async {
    final response = await dioClient.delete('${Endpoints.task}${taskModel?.id}', data: taskModel?.toJson());
    return response;
  }
}