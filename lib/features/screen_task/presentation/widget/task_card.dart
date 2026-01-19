import 'package:delemon_machine_task/core/enums/enums.dart';
import 'package:delemon_machine_task/core/user/current_user.dart';
import 'package:delemon_machine_task/features/screen_subtask/presentation/ui/task_detail_page.dart';
import 'package:delemon_machine_task/features/screen_task/domain/entity/task_entity.dart';
import 'package:delemon_machine_task/features/screen_task/presentation/bloc/task_bloc.dart';
import 'package:delemon_machine_task/features/screen_task/presentation/bloc/task_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;

  
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isAssigned = task.assigneeIds.contains(currentUser.id);
    final canEdit = currentUser.role == UserRole.admin || isAssigned;
    return Card(
      child: ListTile(
        isThreeLine: true,
        onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TaskDetailPage(task: task),
      ),
    );
  },
        title: Text(task.title),
        subtitle:  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Status / Priority / Time
    Text(
      '${task.status.name} • ${task.priority.name} • ${task.timeSpentHours}h',
      style: const TextStyle(fontSize: 12),
    ),

    const SizedBox(height: 4),

    // Dates + Estimate
    Text(
  'Start: ${_fmt(task.startDate)}  •  Due: ${_fmt(task.dueDate)}',
  style: const TextStyle(fontSize: 11, color: Colors.grey),
),

const SizedBox(height: 2),

Text(
  'Est: ${task.estimateHours}h  •  Spent: ${task.timeSpentHours}h',
  style: const TextStyle(fontSize: 11, color: Colors.grey),
),


    const SizedBox(height: 4),

    // Labels (tags)
    if (task.labels.isNotEmpty)
      Wrap(
        spacing: 6,
        runSpacing: -6,
        children: task.labels
            .map(
              (l) => Chip(
                label: Text(l, style: const TextStyle(fontSize: 10)),
                visualDensity: VisualDensity.compact,
              ),
            )
            .toList(),
      ),
  ],
),

        trailing: DropdownButton<TaskStatus>(
          value: task.status,
          items: TaskStatus.values
              .map((s) =>
                  DropdownMenuItem(value: s, child: Text(s.name)))
              .toList(),
          onChanged:canEdit? (v) {
            if (v == null) return;
            final updated = task.copyWith(status: v);
            context.read<TaskBloc>().add(UpdateTask(updated));
          }:null,
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return '-';
  return '${d.day}/${d.month}/${d.year}';
}