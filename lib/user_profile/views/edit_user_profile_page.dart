import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';
import 'package:taskmanager_frontend/models/user_profile/user_profile_model.dart';
import 'package:taskmanager_frontend/user_profile/user_profile_repository.dart';

import '../create_update_delete_bloc/create_update_delete_user_profile_bloc.dart';

class EditUserProfilePage extends StatelessWidget {
  final UserProfileModel? userProfileModel;
  const EditUserProfilePage({Key? key, this.userProfileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUpdateDeleteUserProfileBloc(
          userProfileRepository: getIt<UserProfileRepository>()),
      child: EditUserProfilePageView(userProfileModel: userProfileModel),
    );
  }
}

class EditUserProfilePageView extends StatefulWidget {
  const EditUserProfilePageView({super.key, this.userProfileModel});
  final UserProfileModel? userProfileModel;

  @override
  State<EditUserProfilePageView> createState() => _EditUserProfilePageViewState();
}

class _EditUserProfilePageViewState extends State<EditUserProfilePageView> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Profile'),
      ),
      body: BlocConsumer<CreateUpdateDeleteUserProfileBloc, CreateUpdateDeleteUserProfileState>
        (
        listener: (context, state){
          if(state is CreateUpdateDeleteUserProfileSuccess) {
            FlutterToastr.show('Success', context);
            Navigator.of(context).pop();
          }
          if(state is CreateUpdateDeleteUserProfileError) {
            Fluttertoast.showToast(msg: "an error has occurred");
          }
        },
        builder: (context, state){
          if (state is CreateUpdateDeleteUserProfileLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Padding(
              padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){

                  },
                ),
                Form(child: Column()),
              ],
            ),
          );
        },
      ),
    );
  }
}

