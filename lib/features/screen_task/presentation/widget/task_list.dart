import 'package:delemon_machine_task/features/screen_task/presentation/bloc/task_bloc.dart';
import 'package:delemon_machine_task/features/screen_task/presentation/bloc/task_state.dart';
import 'package:delemon_machine_task/features/screen_task/presentation/widget/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.filtered.isEmpty) {
          return const Center(child: Text('No tasks found'));
        }

        return ListView.builder(
          itemCount: state.filtered.length,
          itemBuilder: (context, index) {
            final task = state.filtered[index];
            return TaskCard(task: task);
          },
        );
      },
    );
  }
}