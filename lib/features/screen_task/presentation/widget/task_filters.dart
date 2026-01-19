import 'package:delemon_machine_task/core/enums/enums.dart';
import 'package:delemon_machine_task/features/screen_task/presentation/bloc/task_bloc.dart';
import 'package:delemon_machine_task/features/screen_task/presentation/bloc/task_event.dart';
import 'package:delemon_machine_task/features/screen_task/presentation/bloc/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

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