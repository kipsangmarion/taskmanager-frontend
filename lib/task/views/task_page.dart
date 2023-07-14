import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';

import 'package:taskmanager_frontend/task/create_update_delete_bloc/create_update_delete_task_bloc.dart';
import 'package:taskmanager_frontend/activity/retrieve_activities_bloc/retrieve_activities_bloc.dart';
import 'package:taskmanager_frontend/activity/views/activity_page.dart';
import 'package:taskmanager_frontend/comment/views/comment_page.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  late String selectedTag;
  List<String> tagOptions = ['Urgent and Important', 'Urgent but Not Important', 'Not Urgent but Important', 'Not Urgent and Not Important'];

  bool isEditMode = false;

  void saveTask() {
    final title = titleController.text;
    final description = descriptionController.text;
    final content = contentController.text;
    final tag = selectedTag;

    final createUpdateDeleteTaskBloc =
    BlocProvider.of<CreateUpdateDeleteTaskBloc>(context);
    createUpdateDeleteTaskBloc.add(
      SaveTask(
        title: title,
        description: description,
        content: content,
        tag: tag,
      ),
    );
  }

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  void navigateToActivityPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityPage(),
      ),
    );
  }

  void navigateToCommentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CreateUpdateDeleteTaskBloc>(
            create: (context) => CreateUpdateDeleteTaskBloc(taskRepository: getIt<TaskRepository>()),
          ),
          BlocProvider<RetrieveActivitiesBloc>(
            create: (context) => RetrieveActivitiesBloc(activityRepository: getIt<ActivityRepository>()),
          ),
        ],
        child: BlocConsumer<CreateUpdateDeleteTaskBloc, CreateUpdateDeleteTaskState>(
          listener: (context, state) {
            if (state is CreateUpdateDeleteTaskSuccess) {
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
                      labelText: 'Task Title',
                    ),
                    readOnly: !isEditMode,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text(
                        'New',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8.0),
                      DropdownButton<String>(
                        value: selectedTag,
                        onChanged: (value) {
                          setState(() {
                            selectedTag = value!;
                          });
                        },
                        items: tagOptions.map((tag) {
                          return DropdownMenuItem<String>(
                            value: tag,
                            child: Text(tag),
                          );
                        }).toList(),
                      ),
                    ],
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
                        saveTask();
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
                  const Text(
                    'Status: New',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Tag: $selectedTag',
                    style: const TextStyle(fontSize: 16),
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
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<RetrieveActivitiesBloc,
                              RetrieveActivitiesState>(
                            builder: (context, state) {
                              if (state is RetrieveActivitiesSuccess) {

                                return ListView.builder(
                                  itemCount: state.activityModel?.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(state.activityModel?[index].title?? ''),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is RetrieveActivitiesLoading) {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                navigateToActivityPage();
                              },
                              child: const Icon(Icons.add),
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
                      ],
                    ),
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
