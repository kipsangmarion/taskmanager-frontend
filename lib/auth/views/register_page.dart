import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_frontend/auth/auth_bloc/auth_bloc.dart';
import 'package:taskmanager_frontend/auth/views/login_page.dart';
import 'package:taskmanager_frontend/models/user/auth_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();
  final email = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: username,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Required';
                }
                return null;
              },
              decoration: const InputDecoration(label: Text('Username')),
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: password,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Required';
                }
                return null;
              },
              decoration: const InputDecoration(label: Text('Password')),
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: password2,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Required';
                }
                return null;
              },
              decoration: const InputDecoration(label: Text('Retype password')),
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: email,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Required';
                }
                return null;
              },
              decoration: const InputDecoration(label: Text('Email')),
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: firstname,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Required';
                }
                return null;
              },
              decoration: const InputDecoration(label: Text('First name')),
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: lastname,
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Required';
                }
                return null;
              },
              decoration: const InputDecoration(label: Text('Last name')),
            ),
            const SizedBox(height: 20,),
            BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state){
                  if (state is AuthSuccess){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false);
                  }
                },
                builder: (context, state) {
                  if(state is AuthLoading){
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return FloatingActionButton.extended(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          BlocProvider.of<AuthBloc>(context).add(
                            RegisterUserEvent(AuthModel(
                              username: username.text,
                              password: password.text,
                              password2: password2.text,
                              email: email.text,
                              firstName: firstname.text,
                              lastName: lastname.text,
                            ),),
                          );
                        }
                      },
                      backgroundColor: Colors.blueGrey,
                      icon: const Icon(Icons.send),
                      label: const Text('Register'),
                  );
                }
            )
          ],),
        ),
      ),
    );
  }
}
