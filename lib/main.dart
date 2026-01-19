import 'package:delemon_machine_task/features/screen_project/data/repository/project_repository_impl.dart';
import 'package:delemon_machine_task/features/screen_report/data/repository/report_repository_impl.dart';
import 'package:delemon_machine_task/features/screen_task/data/repository/task_repository_impl.dart';
import 'package:delemon_machine_task/features/screen_project/domain/repository/project_repository.dart';
import 'package:delemon_machine_task/features/screen_report/domain/repository/report_repository.dart';
import 'package:delemon_machine_task/features/screen_task/domain/repository/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'router/app_router.dart';



void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProjectRepository>(
          create: (_) => ProjectRepositoryImpl(),
        ),
        RepositoryProvider<TaskRepository>(
          create: (_) => TaskRepositoryImpl(),
        ),
        RepositoryProvider<ReportRepository>(
          create: (_) => ReportRepositoryImpl(),
        ),
      ],
      child: MaterialApp.router(
        title: 'TaskFlow Mini',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
