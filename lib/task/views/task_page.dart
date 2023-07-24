import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';

import 'package:taskmanager_frontend/task/create_update_delete_bloc/create_update_delete_task_bloc.dart';
import 'package:taskmanager_frontend/activity/retrieve_activities_bloc/retrieve_activities_bloc.dart';
import 'package:taskmanager_frontend/activity/views/activity_page.dart';
import 'package:taskmanager_frontend/comment/views/comment_page.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';
import 'package:taskmanager_frontend/user_profile/user_bloc/user_bloc.dart';

class TaskPage extends StatelessWidget {
  final TaskModel? taskModel;
  final bool? isEditMode;
  const TaskPage({Key? key, this.taskModel, this.isEditMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateUpdateDeleteTaskBloc(
              taskRepository: getIt<TaskRepository>()),
        ),
        BlocProvider<RetrieveActivitiesBloc>(
          create: (context) => RetrieveActivitiesBloc(
              activityRepository: getIt<ActivityRepository>()),
        ),
      ],
      child: TaskPageView(
        taskModel: taskModel,
        isEditMode: isEditMode,
      ),
    );
  }
}

class TaskPageView extends StatefulWidget {
  const TaskPageView({super.key, this.taskModel, this.isEditMode});
  final TaskModel? taskModel;
  final bool? isEditMode;
  @override
  State<TaskPageView> createState() => _TaskPageViewState();
}

class _TaskPageViewState extends State<TaskPageView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController hoursController = TextEditingController();
  DateTime? plannedStartDate;
  DateTime? plannedEndDate;
  DateTime? actualStartDate;
  DateTime? actualEndDate;

  final _plannedStartDate = TextEditingController();
  final _plannedEndDate = TextEditingController();
  final _actualStartDate = TextEditingController();
  final _actualEndDate = TextEditingController();
  settext() {
    if (widget.taskModel != null) {
      titleController.text = widget.taskModel?.title ?? "";
      descriptionController.text = widget.taskModel?.desc ?? '';
      contentController.text = widget.taskModel?.content ?? "";
      hoursController.text = widget.taskModel?.hours.toString() ?? '';

      _plannedStartDate.text =
          widget.taskModel?.planned_start_date.toString() ?? "";
      _plannedEndDate.text =
          widget.taskModel?.planned_end_date.toString() ?? '';
      _actualStartDate.text =
          widget.taskModel?.actual_start_date.toString() ?? "";
      _actualEndDate.text = widget.taskModel?.actual_end_date.toString() ?? '';

      setState(() {});
    }
  }

  String? selectedTag;
  // List<String> tagOptions = [
  //   'Urgent and Important',
  //   'Urgent but Not Important',
  //   'Not Urgent but Important',
  //   'Not Urgent and Not Important'
  // ];
  List<String> tagOptions = ['UI', 'UNI', 'NUI', 'NUNI'];

  bool isEditMode = true;

  void saveTask() {
    if (_formKey.currentState!.validate()) {
      final tag = selectedTag;
//get an instance of user profile bloc
      final user = context.read<UserBloc>().state.userModel;
      BlocProvider.of<CreateUpdateDeleteTaskBloc>(context)
          .add(CreateTask(TaskModel(
        title: titleController.text,
        user: user?.user_id,
        desc: descriptionController.text,
        content: contentController.text,
        hours: double.parse(hoursController.text),
        tag: tag,
        status: 'NEW',
        planned_start_date: plannedStartDate,
        planned_end_date: plannedEndDate,
        actual_start_date: actualStartDate,
        actual_end_date: actualEndDate,
      )));
    }
  }

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  void navigateToActivityPage() {
    if (widget.taskModel != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActivityPage(
            taskModel: widget.taskModel,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Please create a task first');
    }
  }

  void navigateToCommentPage() {
    //we can use task to get comments, just use task here
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
  void initState() {
    super.initState();
    settext();
    setState(() {
      isEditMode = widget.isEditMode ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body:
          BlocConsumer<CreateUpdateDeleteTaskBloc, CreateUpdateDeleteTaskState>(
        listener: (context, state) {
          if (state is CreateUpdateDeleteTaskSuccess) {
            FlutterToastr.show('Success', context);
            Navigator.of(context).pop();
          }
          if (state is CreateUpdateDeleteTaskError) {
            Fluttertoast.showToast(msg: "an error has occurred");
          }
        },
        builder: (context, state) {
          if (state is CreateUpdateDeleteTaskLoading) {
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
                        labelText: 'Task Title',
                      ),
                      readOnly: !isEditMode,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
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
                      maxLines: 5,
                      readOnly: !isEditMode,
                    ),
                    const SizedBox(height: 16.0),
                    //TODO this start dates fix logic
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100))
                            .then((value) {
                          setState(() {
                            _plannedStartDate.text =
                                DateFormat.MMMEd().format(value!);
                            plannedStartDate = value;
                          });
                        });
                      },
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        enabled: false,
                        decoration: const InputDecoration(
                            label: Text('Planned start date')),
                        controller: _plannedStartDate,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100))
                            .then((value) {
                          setState(() {
                            _plannedEndDate.text =
                                DateFormat.MMMEd().format(value!);
                            plannedEndDate = value;
                          });
                        });
                      },
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        enabled: false,
                        decoration: const InputDecoration(
                            label: Text('Planned End Date')),
                        controller: _plannedEndDate,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100))
                            .then((value) {
                          setState(() {
                            _actualStartDate.text =
                                DateFormat.MMMEd().format(value!);
                            actualStartDate = value;
                          });
                        });
                      },
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        enabled: false,
                        decoration: const InputDecoration(
                            label: Text('Actual start date')),
                        controller: _actualStartDate,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100))
                            .then((value) {
                          setState(() {
                            _actualEndDate.text =
                                DateFormat.MMMEd().format(value!);
                            actualEndDate = value;
                          });
                        });
                      },
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        enabled: false,
                        decoration: const InputDecoration(
                            label: Text('Actual end date')),
                        controller: _actualEndDate,
                      ),
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
                    Row(
                      children: [
                        BlocBuilder<RetrieveActivitiesBloc,
                            RetrieveActivitiesState>(
                          builder: (context, state) {
                            if (state is RetrieveActivitiesSuccess) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.activityModel?.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(
                                          state.activityModel?[index].title ??
                                              ''),
                                      subtitle: Text(
                                          state.activityModel?[index].desc ??
                                              ''),
                                    ),
                                  );
                                },
                              );
                            }
                            if (state is RetrieveActivitiesLoading) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        const SizedBox(width: 16.0),
                        Row(
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
