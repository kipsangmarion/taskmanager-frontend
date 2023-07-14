import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_frontend/comment/comment_repository.dart';

import 'package:taskmanager_frontend/comment/create_update_delete_bloc/create_update_delete_comment_bloc.dart';
import 'package:taskmanager_frontend/comment/retrieve_comments/retrieve_comments_bloc.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentController = TextEditingController();

  void createComment() {
    final commentText = commentController.text;

    final createUpdateDeleteCommentBloc =
    BlocProvider.of<CreateUpdateDeleteCommentBloc>(context);
    createUpdateDeleteCommentBloc.add(
      CreateComment(comment: commentText),
    );

    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment Page'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CreateUpdateDeleteCommentBloc>(
            create: (context) => CreateUpdateDeleteCommentBloc(commentRepository: getIt<CommentRepository>()),
          ),
          BlocProvider<RetrieveCommentsBloc>(
            create: (context) => RetrieveCommentsBloc(commentRepository: getIt<CommentRepository>()),
          ),
        ],
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<RetrieveCommentsBloc, RetrieveCommentsState>(
                builder: (context, state) {
                  if (state is RetrieveCommentsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is RetrieveCommentsSuccess) {

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.commentModel?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.commentModel?[index].content?? ''),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your comment...',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      createComment();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
