import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_frontend/auth/auth_status/auth_status_bloc.dart';
import 'package:taskmanager_frontend/auth/views/login_page.dart';
import 'package:taskmanager_frontend/home/home_page.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});
  Future<void> delayLoading(BuildContext context) async {
    //delayed if you want to show a splash page
    Future.delayed(const Duration(seconds: 2), () {
      BlocProvider.of<AuthStatusBloc>(context).add(CheckAuthStatusEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    delayLoading(context);
    return BlocListener<AuthStatusBloc, AuthStatusState>(
      listener: (context, state) {
        if (state is AuthStatusSuccess) {
// nav to home page
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
                (Route<dynamic> route) => false,
          );
        }
        if (state is AuthStatusLoggedOut) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
                (Route<dynamic> route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}