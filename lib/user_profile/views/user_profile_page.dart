import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController introductionController = TextEditingController();

  late File selectedImage;

  void selectImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void saveUserProfile() {
    BlocProvider.of<CreateUpdateDeleteUserProfileBloc>(context)
        .add(CreateUserProfile(file: selectedImage));
  }

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
                    ListTile(
                      subtitle: const Text('Name'),
                      title: Text(
                          "${state.userModel?.firstName} ${state.userModel?.lastName}"),
                    ),
                    ListTile(
                      subtitle: const Text('Username'),
                      title: Text("${state.userModel?.username} "),
                    ),
                    ListTile(
                      title: Text(state.userModel?.intro ?? ''),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
          //TODO(move_edit_to_own_page) Move edit to its own page
          BlocBuilder<CreateUpdateDeleteUserProfileBloc,
              CreateUpdateDeleteUserProfileState>(
            builder: (context, state) {
              if (state is CreateUpdateDeleteUserProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (state is CreateUpdateDeleteUserProfileSuccess) {
                final userProfile = state.userProfileModel;

                // Initialize text fields with user profile data
                introductionController.text = userProfile?.intro ?? '';

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: selectedImage != null
                              ? DecorationImage(
                                  image: FileImage(selectedImage),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: selectedImage == null
                            ? const Icon(
                                Icons.person,
                                size: 60,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: introductionController,
                      decoration: const InputDecoration(
                        labelText: 'Introduction',
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        saveUserProfile();
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
