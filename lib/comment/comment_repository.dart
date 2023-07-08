import 'package:taskmanager_frontend/comment/comment_api.dart';
import 'package:taskmanager_frontend/models/paginated/links.dart';
import 'package:taskmanager_frontend/models/paginated/paginated_model.dart';
import 'package:taskmanager_frontend/models/comment/comment_model.dart';

class CommentRepository {
  CommentRepository(this.commentAPis);
  final CommentAPis commentAPis;

  Future<PaginatedModel<CommentModel>>? getComment() async {
    final response = await commentAPis.getComment();
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
}