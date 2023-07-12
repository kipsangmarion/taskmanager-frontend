import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_frontend/auth/auth_bloc/auth_bloc.dart';
import 'package:taskmanager_frontend/home/home_page.dart';
import 'package:taskmanager_frontend/models/user/auth_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: username,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                decoration: const InputDecoration(label: Text('USername')),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                decoration: const InputDecoration(label: Text('Passowrd')),
              ),
              const SizedBox(
                height: 12,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    // show success toast

                    // navigate to home screen
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return FilledButton(
                    onPressed: () {
                      // validate all fields are not null
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          LoginUserEvent(
                            AuthModel(
                              username: username.text,
                              password: password.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Login'),
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}