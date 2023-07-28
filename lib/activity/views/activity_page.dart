import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';

import 'package:taskmanager_frontend/activity/create_update_delete_bloc/create_update_delete_activity_bloc.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';

import '../../comment/views/comment_page.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key, required this.taskModel}) : super(key: key);
  final TaskModel? taskModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUpdateDeleteActivityBloc(
          activityRepository: getIt<ActivityRepository>()),
      child: ActivityPageView(taskModel: taskModel),
    );
  }
}

class ActivityPageView extends StatefulWidget {
  const ActivityPageView({super.key, this.taskModel});
  final TaskModel? taskModel;
  @override
  State<ActivityPageView> createState() => _ActivityPageViewState();
}

class _ActivityPageViewState extends State<ActivityPageView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController hoursController = TextEditingController();

  bool isEditMode = true;

  void saveActivity() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<CreateUpdateDeleteActivityBloc>(context)
          .add(CreateActivity(ActivityModel(
        title: titleController.text,
        status: 'NEW',
        task: widget.taskModel?.id,
        desc: descriptionController.text,
        content: contentController.text,
        hours: double.parse(hoursController.text),
      )));
    }
  }

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  void navigateToCommentPage() {
    if (widget.taskModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentPage(
            activityModel: ActivityModel(task: widget.taskModel?.id),
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Please create a task first');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: BlocProvider(
        create: (context) => CreateUpdateDeleteActivityBloc(
            activityRepository: getIt<ActivityRepository>()),
        child: BlocConsumer<CreateUpdateDeleteActivityBloc,
            CreateUpdateDeleteActivityState>(
          listener: (context, state) {
            if (state is CreateUpdateDeleteActivitySuccess) {
              Fluttertoast.showToast(msg: "Success");
              Navigator.of(context).pop();
            }
            if (state is CreateUpdateDeleteActivityError) {
              Fluttertoast.showToast(msg: "an error has occurred");
            }
          },
          builder: (context, state) {
            if (state is CreateUpdateDeleteActivityLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Activity Title',
                        ),
                        readOnly: !isEditMode,
                      ),
                      const SizedBox(height: 16.0),
                      const Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                            'New',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        label: Text(
                          'New',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        readOnly: !isEditMode,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: contentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Content',
                        ),
                        maxLines: 5,
                        readOnly: !isEditMode,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: hoursController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Hours',
                        ),
                        maxLines: 1,
                        readOnly: !isEditMode,
                      ),
                      const SizedBox(height: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {
                          if (isEditMode) {
                            saveActivity();
                          } else {
                            toggleEditMode();
                          }
                        },
                        backgroundColor: Colors.blueGrey.shade200,
                        icon: const Icon(Icons.save), label: const Text('save'),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        titleController.text,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Description: ${descriptionController.text}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Content: ${contentController.text}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {
                          navigateToCommentPage();
                        },
                        backgroundColor: Colors.blueGrey.shade200,
                        icon: const Icon(Icons.comment), label: const Text('comments'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
