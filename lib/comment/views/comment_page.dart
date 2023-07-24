import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager_frontend/comment/comment_repository.dart';

import 'package:taskmanager_frontend/comment/create_update_delete_bloc/create_update_delete_comment_bloc.dart';
import 'package:taskmanager_frontend/comment/retrieve_comments/retrieve_comments_bloc.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';
import 'package:taskmanager_frontend/models/comment/comment_model.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';

class CommentPage extends StatelessWidget {
  final ActivityModel? activityModel;
  final TaskModel? taskModel;
  const CommentPage({Key? key, this.taskModel, this.activityModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateUpdateDeleteCommentBloc(
              commentRepository: getIt<CommentRepository>()),
        ),
        BlocProvider(
          create: (context) => RetrieveCommentsBloc(
              commentRepository: getIt<CommentRepository>()),
        ),
      ],
      child:
          CommentPageView(activityModel: activityModel, taskModel: taskModel),
    );
  }
}

class CommentPageView extends StatefulWidget {
  const CommentPageView({super.key, this.taskModel, this.activityModel});
  final ActivityModel? activityModel;
  final TaskModel? taskModel;
  @override
  State<CommentPageView> createState() => _CommentPageViewState();
}

class _CommentPageViewState extends State<CommentPageView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

  void saveComment() {
    BlocProvider.of<CreateUpdateDeleteCommentBloc>(context)
        .add(CreateComment(CommentModel(
      task: widget.activityModel?.task ?? widget.taskModel?.id,
      activity: widget.activityModel?.id,
      content: commentController.text,
    )));
  }

  void createComment() {
    saveComment();
    commentController.clear();
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  getComments() {
    BlocProvider.of<RetrieveCommentsBloc>(context).add(RetrieveUserComments(
        task: widget.activityModel?.task ?? widget.taskModel?.id,
        activity: widget.activityModel?.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment Page'),
      ),
      body: BlocListener<CreateUpdateDeleteCommentBloc,
          CreateUpdateDeleteCommentState>(
        listener: (context, state) {
          if (state is CreateUpdateDeleteCommentSuccess) {
            getComments();
          }
        },
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<RetrieveCommentsBloc, RetrieveCommentsState>(
                listener: (context, state) {
                  if (state is RetrieveCommentsError) {
                    Fluttertoast.showToast(msg: "an error has occurred");
                  }
                },
                builder: (context, state) {
                  if (state is RetrieveCommentsLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (state is RetrieveCommentsSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.commentModel?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.commentModel?[index].content ?? ''),
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
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
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
            ),
          ],
        ),
      ),
    );
  }
}
