part of 'create_update_delete_comment_bloc.dart';

abstract class CreateUpdateDeleteCommentState extends Equatable {
  const CreateUpdateDeleteCommentState();
  @override
  List<Object> get props => [];
}

class CreateUpdateDeleteCommentInitial extends CreateUpdateDeleteCommentState {
}

class CreateUpdateDeleteCommentLoading extends CreateUpdateDeleteCommentState {
}

class CreateUpdateDeleteCommentSuccess extends CreateUpdateDeleteCommentState {
  final CommentModel? commentModel;
  const CreateUpdateDeleteCommentSuccess(this.commentModel);
}

class CreateUpdateDeleteCommentError extends CreateUpdateDeleteCommentState {
  const CreateUpdateDeleteCommentError(this.errorMessage);

  final String? errorMessage;
}