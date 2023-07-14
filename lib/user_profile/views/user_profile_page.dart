import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:taskmanager_frontend/user_profile/create_update_delete_bloc/create_update_delete_user_profile_bloc.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController introductionController = TextEditingController();

  late File selectedImage;

  void selectImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void updateUserProfile() {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final introduction = introductionController.text;

    final createUpdateDeleteUserProfileBloc =
    BlocProvider.of<CreateUpdateDeleteUserProfileBloc>(context);
    createUpdateDeleteUserProfileBloc.add(
      UpdateUserProfile(
        firstName: firstName,
        lastName: lastName,
        introduction: introduction,
        profileImage: selectedImage,
      ),
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
          } else if (state is CreateUpdateDeleteUserProfileSuccess) {
            final userProfile = state.userProfile;

            // Initialize text fields with user profile data
            firstNameController.text = userProfile.firstName;
            lastNameController.text = userProfile.lastName;
            introductionController.text = userProfile.introduction;

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
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
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
                    updateUserProfile();
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
