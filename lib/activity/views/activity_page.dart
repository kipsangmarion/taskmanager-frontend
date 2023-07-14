import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';

import 'package:taskmanager_frontend/activity/create_update_delete_bloc/create_update_delete_activity_bloc.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';

import '../../comment/views/comment_page.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController hoursController = TextEditingController();

  bool isEditMode = false;

  void saveActivity() {
    BlocProvider.of<CreateUpdateDeleteActivityBloc>(context).add(
      CreateActivity(ActivityModel(
        title: titleController.text,
        desc: descriptionController.text,
        content: contentController.text,
        hours: int.parse(hoursController.text),
      ))
    );
  }

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  void navigateToCommentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CommentPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: BlocProvider(
        create: (context) => CreateUpdateDeleteActivityBloc(activityRepository: getIt<ActivityRepository>()),
        child: BlocConsumer<CreateUpdateDeleteActivityBloc, CreateUpdateDeleteActivityState>(
          listener: (context, state) {
            if (state is CreateUpdateDeleteActivitySuccess) {
              setState(() {
                isEditMode = false;
              });
            }
            if (state is CreateUpdateDeleteActivityError){
              Fluttertoast.showToast(msg: "an error has occurred");
            }
          },
          builder: (context, state) {
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
                      ElevatedButton(
                        onPressed: () {
                          if (isEditMode) {
                            saveActivity();
                          } else {
                            toggleEditMode();
                          }
                        },
                        child: Text(isEditMode ? 'Save' : 'Edit'),
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
                      ElevatedButton(
                        onPressed: () {
                          navigateToCommentPage();
                        },
                        child: const Text('Comments'),
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
