part of 'retrieve_comments_bloc.dart';

abstract class RetrieveCommentsEvent extends Equatable {
  const RetrieveCommentsEvent();

  @override
  List<Object> get props => [];
}

class RetrieveUserComments extends RetrieveCommentsEvent{}
