import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';
import 'package:taskmanager_frontend/activity/retrieve_activities_bloc/retrieve_activities_bloc.dart';
import 'package:taskmanager_frontend/activity/views/activity_details.dart';
import 'package:taskmanager_frontend/activity/views/activity_page.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';

class TaskActivitiesPage extends StatelessWidget {
  final TaskModel? taskModel;

  const TaskActivitiesPage({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: TaskActivitiesPageView(taskModel: taskModel),
        create: (_) => RetrieveActivitiesBloc(
            activityRepository: getIt<ActivityRepository>()));
  }
}

class TaskActivitiesPageView extends StatelessWidget {
  const TaskActivitiesPageView({super.key, required this.taskModel});
  final TaskModel? taskModel;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RetrieveActivitiesBloc>(context)
        .add(RetrieveUserActivities(task: taskModel?.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Activities'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityPage(
                taskModel: taskModel,
              ),
            ),
          );
        },
        backgroundColor: Colors.blueGrey.shade200,
        icon: const Icon(Icons.add), label: const Text('new'),
      ),
      body: BlocBuilder<RetrieveActivitiesBloc, RetrieveActivitiesState>(
        builder: (context, state) {
          if (state is RetrieveActivitiesLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is RetrieveActivitiesEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          }
          if (state is RetrieveActivitiesSuccess) {
            return ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: state.activityModel?.length,
                itemBuilder: (_, i) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityDetailsPage(
                              activityModel: state.activityModel?[i],
                            ),
                          ),
                        );
                      },
                      subtitle: Text(state.activityModel?[i].desc ?? ''),
                      title: Text(state.activityModel?[i].title ?? ''),
                    ),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
