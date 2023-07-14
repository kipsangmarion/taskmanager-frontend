import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager_frontend/task/create_update_delete_bloc/create_update_delete_task_bloc.dart';
import 'package:taskmanager_frontend/task/retrieve_tasks_bloc/retrieve_tasks_bloc.dart';
import 'package:taskmanager_frontend/user_profile/views/user_profile_page';
import 'package:taskmanager_frontend/task/views/task_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Retrieve tasks on page load
    final retrieveTasksBloc = BlocProvider.of<RetrieveTasksBloc>(context);
    retrieveTasksBloc.add(RetrieveAllTasks());
  }

  void navigateToUserProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(),
      ),
    );
  }

  void navigateToTaskPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskPage(),
      ),
    );
  }

  void filterTasksByTag(String tag) {
    final retrieveTasksBloc = BlocProvider.of<RetrieveTasksBloc>(context);
    retrieveTasksBloc.add(RetrieveTasksByTag(tag));
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
              child: Text('Drawer Header'),
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
                filterTasksByTag('Urgent and Important');
              },
            ),
            ListTile(
              title: const Text('Urgent but Not Important'),
              onTap: () {
                filterTasksByTag('Urgent but Not Important');
              },
            ),
            ListTile(
              title: const Text('Not Urgent but Important'),
              onTap: () {
                filterTasksByTag('Not Urgent but Important');
              },
            ),
            ListTile(
              title: const Text('Not Urgent and Not Important'),
              onTap: () {
                filterTasksByTag('Not Urgent and Not Important');
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
          } else if (state is RetrieveTasksSuccess) {

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
        child: Icon(Icons.add),
      ),
    );
  }
}
