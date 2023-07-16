import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:taskmanager_frontend/user_profile/create_update_delete_bloc/create_update_delete_user_profile_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController introductionController = TextEditingController();

  late File selectedImage;

  void selectImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void saveUserProfile() {
    BlocProvider.of<CreateUpdateDeleteUserProfileBloc>(context).add(
      CreateUserProfile(file: selectedImage)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: BlocBuilder<CreateUpdateDeleteUserProfileBloc, CreateUpdateDeleteUserProfileState>(
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

            return ListView(
              padding: const EdgeInsets.all(16.0),
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
    );
  }
}
