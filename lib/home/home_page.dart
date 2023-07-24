import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager_frontend/auth/views/login_page.dart';

import 'package:taskmanager_frontend/task/retrieve_tasks_bloc/retrieve_tasks_bloc.dart';
import 'package:taskmanager_frontend/task/views/task_details.dart';
import 'package:taskmanager_frontend/user_profile/user_bloc/user_bloc.dart';
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
    BlocProvider.of<RetrieveTasksBloc>(context).add(const RetrieveUserTasks());
    BlocProvider.of<UserBloc>(context).add(GetUserProfile());
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
    BlocProvider.of<RetrieveTasksBloc>(context)
        .add(RetrieveUserTasks(tag: tag));
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
            BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state.profileStateStatus == ProfileStateStatus.failure) {
                  Fluttertoast.showToast(msg: state.message ?? 'Error');
                }
              },
              builder: (context, state) {
                if (state.profileStateStatus == ProfileStateStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.profileStateStatus == ProfileStateStatus.success) {
                  return ListTile(
                    onTap: () {
                      navigateToUserProfilePage();
                    },
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    subtitle: Text(state.userModel?.intro ?? ''),
                    title: Text(
                        "${state.userModel?.firstName} ${state.userModel?.lastName}"),
                  );
                }
                return ListTile(
                  title: const Text('User Profile'),
                  onTap: () {
                    navigateToUserProfilePage();
                  },
                );
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
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            )
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
            return SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.taskModel?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailspage(
                              taskModel: state.taskModel?[index]),
                        ),
                      );
                    },
                    title: Text(state.taskModel?[index].title ?? ''),
                  );
                },
              ),
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
