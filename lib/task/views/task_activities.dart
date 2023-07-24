import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';
import 'package:taskmanager_frontend/activity/retrieve_activities_bloc/retrieve_activities_bloc.dart';
import 'package:taskmanager_frontend/activity/views/activity_details.dart';
import 'package:taskmanager_frontend/activity/views/activity_page.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';

class TaskActivitesPage extends StatelessWidget {
  final TaskModel? taskModel;

  const TaskActivitesPage({super.key, required this.taskModel});

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
      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<RetrieveActivitiesBloc, RetrieveActivitiesState>(
        builder: (context, state) {
          if (state is RetrieveActivitiesLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is RetrieveActivitiesEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }
          if (state is RetrieveActivitiesSuccess) {
            return ListView.builder(
                itemCount: state.activityModel?.length,
                itemBuilder: (_, i) {
                  return ListTile(
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
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
