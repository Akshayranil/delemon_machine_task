import 'package:delemon_machine_task/features/screen_task/presentation/widget/task_filters.dart';
import 'package:delemon_machine_task/features/screen_task/presentation/widget/task_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';


class TasksPage extends StatelessWidget {
  final String projectId;
  const TasksPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaskBloc(context.read())..add(LoadTasks(projectId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Tasks')),
        body: Column(
          children: [
            Filters(),
            Expanded(child: TaskList()),
          ],
        ),
      ),
    );
  }
}











