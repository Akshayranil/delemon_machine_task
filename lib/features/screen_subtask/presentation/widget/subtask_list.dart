import 'package:delemon_machine_task/features/screen_subtask/presentation/bloc/subtask_bloc.dart';
import 'package:delemon_machine_task/features/screen_subtask/presentation/bloc/subtask_event.dart';
import 'package:delemon_machine_task/features/screen_subtask/presentation/bloc/subtask_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubtaskList extends StatelessWidget {
  final String taskId;
  const SubtaskList({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtaskBloc, SubtaskState>(
      builder: (context, state) {
        if (state is SubtaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SubtaskError) {
          return Center(child: Text(state.message));
        }

        if (state is SubtaskLoaded) {
          if (state.subtasks.isEmpty) {
            return const Center(child: Text('No subtasks yet'));
          }

          return ListView.builder(
            itemCount: state.subtasks.length,
            itemBuilder: (context, index) {
              final subtask = state.subtasks[index];

              return CheckboxListTile(
                value: subtask.isDone,
                title: Text(
                  subtask.title,
                  style: TextStyle(
                    decoration: subtask.isDone
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                onChanged: (_) {
                  context
                      .read<SubtaskBloc>()
                      .add(ToggleSubtask(subtask));
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}