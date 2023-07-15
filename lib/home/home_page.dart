import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager_frontend/task/retrieve_tasks_bloc/retrieve_tasks_bloc.dart';
import 'package:taskmanager_frontend/user_profile/views/user_profile_page.dart';
import 'package:taskmanager_frontend/task/views/task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Retrieve tasks on page load
    final retrieveTasksBloc = BlocProvider.of<RetrieveTasksBloc>(context);
    retrieveTasksBloc.add(const RetrieveUserTasks());
  }

  void navigateToUserProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserProfilePage(),
      ),
    );
  }

  void navigateToTaskPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TaskPage(),
      ),
    );
  }

  void filterTasksByTag(String tag) {
    final retrieveTasksBloc = BlocProvider.of<RetrieveTasksBloc>(context);
    retrieveTasksBloc.add(RetrieveUserTasks(tag: tag));
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('TaskMaster'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Taskmaster'),
            ),
            ListTile(
              title: const Text('User Profile'),
              onTap: () {
                navigateToUserProfilePage();
              },
            ),
            ListTile(
              title: const Text('Urgent and Important'),
              onTap: () {
                filterTasksByTag('UI');
              },
            ),
            ListTile(
              title: const Text('Urgent but Not Important'),
              onTap: () {
                filterTasksByTag('UNI');
              },
            ),
            ListTile(
              title: const Text('Not Urgent but Important'),
              onTap: () {
                filterTasksByTag('NUI');
              },
            ),
            ListTile(
              title: const Text('Not Urgent and Not Important'),
              onTap: () {
                filterTasksByTag('NUNI');
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<RetrieveTasksBloc, RetrieveTasksState>(
        builder: (context, state) {
          if (state is RetrieveTasksLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is RetrieveTasksSuccess) {

            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.taskModel?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(state.taskModel?[index].title ?? ''),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToTaskPage();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
