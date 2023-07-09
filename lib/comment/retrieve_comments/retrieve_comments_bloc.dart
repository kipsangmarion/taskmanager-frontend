import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager_frontend/comment/comment_repository.dart';

import '../../models/comment/comment_model.dart';

part 'retrieve_comments_event.dart';
part 'retrieve_comments_state.dart';

class RetrieveCommentsBloc extends Bloc<RetrieveCommentsEvent, RetrieveCommentsState> {
  RetrieveCommentsBloc({required CommentRepository commentRepository})
      : _commentRepository = commentRepository,
        super(RetrieveCommentsInitial()) {
    on<RetrieveCommentsEvent>((event, emit) async{
      try{
        emit.call(RetrieveCommentsLoading());
        final comments = await _commentRepository.getComments();
        emit.call(RetrieveCommentsSuccess(comments?.results));
      } on DioException catch(e){
        emit.call(RetrieveCommentsError(e.toString()));
      } catch(e){
        emit.call(RetrieveCommentsError(e.toString()));
      }
    });
  }
  final CommentRepository _commentRepository;
}
