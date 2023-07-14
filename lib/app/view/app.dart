import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';
import 'package:taskmanager_frontend/activity/create_update_delete_bloc/create_update_delete_activity_bloc.dart';
import 'package:taskmanager_frontend/activity/retrieve_activities_bloc/retrieve_activities_bloc.dart';
import 'package:taskmanager_frontend/auth/auth_bloc/auth_bloc.dart';
import 'package:taskmanager_frontend/auth/auth_repository.dart';
import 'package:taskmanager_frontend/auth/auth_status/auth_status_bloc.dart';
import 'package:taskmanager_frontend/comment/comment_repository.dart';
import 'package:taskmanager_frontend/comment/create_update_delete_bloc/create_update_delete_comment_bloc.dart';
import 'package:taskmanager_frontend/comment/retrieve_comments/retrieve_comments_bloc.dart';
import 'package:taskmanager_frontend/di/service_locator.dart';
import 'package:taskmanager_frontend/home/root_screen.dart';
import 'package:taskmanager_frontend/l10n/l10n.dart';
import 'package:taskmanager_frontend/task/create_update_delete_bloc/create_update_delete_task_bloc.dart';
import 'package:taskmanager_frontend/task/retrieve_tasks_bloc/retrieve_tasks_bloc.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';
import 'package:taskmanager_frontend/user_profile/create_update_delete_bloc/create_update_delete_user_profile_bloc.dart';
import 'package:taskmanager_frontend/user_profile/user_profile_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Given that we need an instance of this blocs gloablly we initialize them here
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
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        //localizationsDelegates: AppLocalizations.localizationsDelegates,
        //supportedLocales: AppLocalizations.supportedLocales,
        home: const RootScreen(),
      ),
    );
  }
}