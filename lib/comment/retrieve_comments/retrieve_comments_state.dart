part of 'retrieve_comments_bloc.dart';

abstract class RetrieveCommentsState extends Equatable {
  const RetrieveCommentsState();

  @override
  List<Object> get props => [];
}

class RetrieveCommentsInitial extends RetrieveCommentsState {
}

class RetrieveCommentsLoading extends RetrieveCommentsState {
}

class RetrieveCommentsSuccess extends RetrieveCommentsState {
  final List<CommentModel>? commentModel;

  const RetrieveCommentsSuccess(this.commentModel);
}

class RetrieveCommentsError extends RetrieveCommentsState {
  const RetrieveCommentsError(this.errorMessage);

  final String? errorMessage;
}
