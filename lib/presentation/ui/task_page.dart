import 'package:delemon_machine_task/presentation/ui/task_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/enums.dart';
import '../../domain/entities/task_entity.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';
import '../blocs/task/task_state.dart';

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
            _Filters(),
            Expanded(child: _TaskList()),
          ],
        ),
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (v) {
                  context.read<TaskBloc>().add(ApplyFilters(
                        status: state.status,
                        priority: state.priority,
                        assigneeId: state.assigneeId,
                        search: v,
                      ));
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _statusDropdown(context, state),
                  const SizedBox(width: 8),
                  _priorityDropdown(context, state),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusDropdown(BuildContext context, TaskState state) {
    return Expanded(
      child: DropdownButtonFormField<TaskStatus?>(
        value: state.status,
        hint: const Text('Status'),
        items: [
          const DropdownMenuItem(value: null, child: Text('All')),
          ...TaskStatus.values.map(
            (s) => DropdownMenuItem(value: s, child: Text(s.name)),
          ),
        ],
        onChanged: (v) {
          context.read<TaskBloc>().add(ApplyFilters(
                status: v,
                priority: state.priority,
                assigneeId: state.assigneeId,
                search: state.search,
              ));
        },
      ),
    );
  }

  Widget _priorityDropdown(BuildContext context, TaskState state) {
    return Expanded(
      child: DropdownButtonFormField<TaskPriority?>(
        value: state.priority,
        hint: const Text('Priority'),
        items: [
          const DropdownMenuItem(value: null, child: Text('All')),
          ...TaskPriority.values.map(
            (p) => DropdownMenuItem(value: p, child: Text(p.name)),
          ),
        ],
        onChanged: (v) {
          context.read<TaskBloc>().add(ApplyFilters(
                status: state.status,
                priority: v,
                assigneeId: state.assigneeId,
                search: state.search,
              ));
        },
      ),
    );
  }
}


class _TaskList extends StatelessWidget {
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
            return _TaskCard(task: task);
          },
        );
      },
    );
  }
}


class _TaskCard extends StatelessWidget {
  final TaskEntity task;
  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
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
          onChanged: (v) {
            if (v == null) return;
            final updated = task.copyWith(status: v);
            context.read<TaskBloc>().add(UpdateTask(updated));
          },
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return '-';
  return '${d.day}/${d.month}/${d.year}';
}

