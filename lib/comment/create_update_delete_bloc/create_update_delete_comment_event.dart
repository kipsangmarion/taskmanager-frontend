part of 'create_update_delete_comment_bloc.dart';

abstract class CreateUpdateDeleteCommentEvent extends Equatable {
  const CreateUpdateDeleteCommentEvent();

  @override
  List<Object> get props => [];
}

class CreateComment extends CreateUpdateDeleteCommentEvent{
  final CommentModel? comment;

  const CreateComment(this.comment);
}

class UpdateComment extends CreateUpdateDeleteCommentEvent{
  final CommentModel? comment;

  const UpdateComment(this.comment);
}

class DeleteComment extends CreateUpdateDeleteCommentEvent{
  final CommentModel? comment;

  const DeleteComment(this.comment);
}

class RetrieveIndividualComment extends CreateUpdateDeleteCommentEvent{
  final int? comment;

  const RetrieveIndividualComment(this.comment);
}