import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/comment/comment_repository.dart';
import 'package:taskmanager_frontend/models/comment/comment_model.dart';

part 'create_update_delete_comment_event.dart';
part 'create_update_delete_comment_state.dart';

class CreateUpdateDeleteCommentBloc extends Bloc<CreateUpdateDeleteCommentEvent, CreateUpdateDeleteCommentState> {
  CreateUpdateDeleteCommentBloc({required CommentRepository commentRepository})
      : _commentRepository = commentRepository,
        super(CreateUpdateDeleteCommentInitial()) {
    on<CreateComment>((event, emit) async{
      try{
        emit.call(CreateUpdateDeleteCommentLoading());
        final comment = await _commentRepository.createComment(event.comment);
        emit.call(CreateUpdateDeleteCommentSuccess(comment));
      } catch(e){
        emit.call(CreateUpdateDeleteCommentError(e.toString()));
      }
    });

    on<UpdateComment>((event, emit) async{
      try{
        emit.call(CreateUpdateDeleteCommentLoading());
        final comment = await _commentRepository.updateComment(event.comment);
        emit.call(CreateUpdateDeleteCommentSuccess(comment));
      } catch(e){
        emit.call(CreateUpdateDeleteCommentError(e.toString()));
      }
    });

    on<DeleteComment>((event,emit) async{
      try{
        emit.call(CreateUpdateDeleteCommentLoading());
        final comment = await _commentRepository.deleteComment(event.comment);
        emit.call(CreateUpdateDeleteCommentSuccess(comment));
      } catch(e){
        emit.call(CreateUpdateDeleteCommentError(e.toString()));
      }
    });

    on<RetrieveIndividualComment>((event, emit) async {
      try {
        emit.call(CreateUpdateDeleteCommentLoading());
        //TODO get retrieve individual task given id
        final comment = await _commentRepository.retrieveSpecificComment(event.comment);
        emit.call(CreateUpdateDeleteCommentSuccess(comment));
      } catch (e) {
        emit.call(CreateUpdateDeleteCommentError(e.toString()));
      }
    });
  }
  final CommentRepository _commentRepository;
}
