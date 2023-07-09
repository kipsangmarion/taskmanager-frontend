import 'package:taskmanager_frontend/comment/comment_api.dart';
import 'package:taskmanager_frontend/models/paginated/links.dart';
import 'package:taskmanager_frontend/models/paginated/paginated_model.dart';
import 'package:taskmanager_frontend/models/comment/comment_model.dart';

class CommentRepository {
  CommentRepository(this.commentAPis);
  final CommentAPis commentAPis;

  Future<PaginatedModel<CommentModel>>? getComments({
    int? task,
    int? activity,
  }) async {
    final response = await commentAPis.getComments(task: task, activity: activity);
    return PaginatedModel(
      lastPage: response?['data']['last_page'] as int,
      links: Links.fromJson(response?['data']['links'] as Map<String, dynamic>),
      results: (response?['data']['results'] as List)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<CommentModel>? createComment(CommentModel? commentModel) async {
    final response = await commentAPis.createComment(commentModel);
    return CommentModel.fromJson(response?['data'] as Map<String, dynamic>);
  }

  Future<CommentModel>? updateComment(CommentModel? commentModel) async {
    final response = await commentAPis.updateComment(commentModel);
    return CommentModel.fromJson(response?['data'] as Map<String, dynamic>);
  }

  Future<CommentModel>? deleteComment(CommentModel? commentModel) async {
    final response = await commentAPis.deleteComment(commentModel);
    return CommentModel.fromJson(response?['data'] as Map<String, dynamic>);
  }

  Future<CommentModel>? retrieveSpecificComment(int? comment) async {
    final response = await commentAPis.retrieveSpecificComment(comment);
    return CommentModel.fromJson(response?['data'] as Map<String, dynamic>);
  }
}