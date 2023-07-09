import 'package:taskmanager_frontend/models/comment/comment_model.dart';
import 'package:taskmanager_frontend/network/api/endpoints.dart';
import 'package:taskmanager_frontend/network/dio_client.dart';

import '../models/paginated/paginated_model.dart';

class CommentAPis {
  CommentAPis(this.dioClient);

  final DioClient dioClient;

  Future<Map<String, dynamic>?> createComment(
      CommentModel? commentModel,
      ) async {
    final response = await dioClient.post(Endpoints.comment, data: commentModel?.toJson());
    return response;
  }

  Future<Map<String, dynamic>?> retrieveComments({
    int? activity,
    int? task,
  }) async {
    final response = await dioClient.get(Endpoints.comment,
        queryParameters: {'activity': activity, 'task': task}
    );
    return response;
  }

  Future<Map<String, dynamic>?> retrieveSpecificComment(
      int? comment,
      ) async {
    final response = await dioClient.get(
      '${Endpoints.comment}$comment',
    );
    return response;
  }
}