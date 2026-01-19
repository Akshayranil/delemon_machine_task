import 'package:delemon_machine_task/features/screen_subtask/domain/entity/subtask_entity.dart';
import 'package:delemon_machine_task/features/screen_subtask/presentation/bloc/subtask_bloc.dart';
import 'package:delemon_machine_task/features/screen_subtask/presentation/bloc/subtask_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSubtaskButton extends StatelessWidget {
  final String taskId;
  const AddSubtaskButton({super.key, required this.taskId});

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