import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager_frontend/user_profile/views/edit_user_profile_page.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';

import 'package:taskmanager_frontend/user_profile/create_update_delete_bloc/create_update_delete_user_profile_bloc.dart';
import 'package:taskmanager_frontend/user_profile/user_bloc/user_bloc.dart';
import 'package:taskmanager_frontend/user_profile/user_profile_repository.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CreateUpdateDeleteUserProfileBloc(
            userProfileRepository: getIt<UserProfileRepository>()),
        child: const UserProfilePageView());
  }
}

class UserProfilePageView extends StatefulWidget {
  const UserProfilePageView({super.key});

  @override
  State<UserProfilePageView> createState() => _UserProfilePageViewState();
}

class _UserProfilePageViewState extends State<UserProfilePageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Column(
        children: [
          // user details
          // For now no profile edit and stuff
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
                return Column(
                  children: [
                    const SizedBox(height: 25,),
                    (state.userModel?.image?.isNotEmpty ?? false)
                        ? CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: CachedNetworkImageProvider(state
                          .userModel?.image! ??
                          'https://avatars.dicebear.com/api/initials/${state.userModel?.firstName}.png'),
                    )
                        : const Icon(
                      Icons.person,
                      size: 60,
                    ),
                    const SizedBox(height: 25,),
                    ListTile(
                      title: const Text('Name'),
                      subtitle: Text(
                          "${state.userModel?.firstName} ${state.userModel?.lastName}"),
                    ),
                    ListTile(
                      title: const Text('Username'),
                      subtitle: Text("${state.userModel?.username} "),
                    ),
                    ListTile(
                      title: Text(state.userModel?.intro ?? ''),
                    ),
                    const SizedBox(height: 30,),
                    FloatingActionButton.extended(
                      onPressed: () {
                        //TODO: TaskPage edit profile
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditUserProfilePage(),
                          ),
                        );
                      },
                      backgroundColor: Colors.blueGrey.shade200,
                      icon: const Icon(Icons.edit), label: const Text('edit'),),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
