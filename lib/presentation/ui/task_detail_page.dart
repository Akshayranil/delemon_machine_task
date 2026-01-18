import 'package:delemon_machine_task/domain/repository/task_repository.dart';
import 'package:delemon_machine_task/presentation/blocs/bloc/subtask_bloc.dart';
import 'package:delemon_machine_task/presentation/blocs/bloc/subtask_event.dart';
import 'package:delemon_machine_task/presentation/blocs/bloc/subtask_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/entities/subtask_entity.dart';


class TaskDetailPage extends StatelessWidget {
  final TaskEntity task;
  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubtaskBloc(context.read<TaskRepository>())
        ..add(LoadSubtasks(task.id)),
      child: Scaffold(
        appBar: AppBar(title: Text(task.title)),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(task.description),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Subtasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: _SubtaskList(taskId: task.id)),
          ],
        ),
        floatingActionButton: _AddSubtaskButton(taskId: task.id),
      ),
    );
  }
}


class _SubtaskList extends StatelessWidget {
  final String taskId;
  const _SubtaskList({required this.taskId});

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


class _AddSubtaskButton extends StatelessWidget {
  final String taskId;
  const _AddSubtaskButton({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => _showAddDialog(context),
    );
  }

  void _showAddDialog(BuildContext context) {
    final ctrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Subtask'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(hintText: 'Subtask title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final subtask = SubtaskEntity(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                taskId: taskId,
                title: ctrl.text,
                isDone: false,
              );

              context.read<SubtaskBloc>().add(AddSubtask(subtask));
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

