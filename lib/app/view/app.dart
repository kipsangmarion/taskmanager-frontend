import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager_frontend/auth/auth_bloc/auth_bloc.dart';
import 'package:taskmanager_frontend/auth/auth_repository.dart';
import 'package:taskmanager_frontend/auth/auth_status/auth_status_bloc.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';
import 'package:taskmanager_frontend/home/root_screen.dart';
import 'package:taskmanager_frontend/task/retrieve_tasks_bloc/retrieve_tasks_bloc.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';
import 'package:taskmanager_frontend/user_profile/user_bloc/user_bloc.dart';
import 'package:taskmanager_frontend/user_profile/user_profile_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserBloc(userProfileRepository: getIt<UserProfileRepository>()),
        ),

        BlocProvider(
          create: (context) =>
              RetrieveTasksBloc(taskRepository: getIt<TaskRepository>()),
        ),
        // Given that we need an instance of this blocs globally we initialize them here
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: getIt<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) => AuthStatusBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme.apply(fontSizeFactor: 1.2,fontSizeDelta: 2.0)),
          colorScheme: const ColorScheme.light(primary: Colors.blueGrey),
        ),
        //localizationsDelegates: AppLocalizations.localizationsDelegates,
        //supportedLocales: AppLocalizations.supportedLocales,
        home: const RootScreen(),
      ),
    );
  }
}
