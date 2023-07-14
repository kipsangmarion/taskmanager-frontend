import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';

import 'package:taskmanager_frontend/activity/create_update_delete_bloc/create_update_delete_activity_bloc.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  bool isEditMode = false;

  void saveActivity() {
    final title = titleController.text;
    final description = descriptionController.text;
    final content = contentController.text;

    final createUpdateDeleteActivityBloc =
    BlocProvider.of<CreateUpdateDeleteActivityBloc>(context);
    createUpdateDeleteActivityBloc.add(
      SaveActivity(
        title: title,
        description: description,
        content: content,
      ),
    );
  }

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  // void navigateToCommentPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CommentPage(),
  //     ),
  //   );
  // }

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
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Activity Title',
                    ),
                    readOnly: !isEditMode,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'New',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    readOnly: !isEditMode,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                    ),
                    maxLines: 5,
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
                      // Handle Comments button tap
                    },
                    child: const Text('Comments'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
