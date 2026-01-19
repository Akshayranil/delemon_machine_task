import 'package:delemon_machine_task/features/screen_subtask/presentation/widget/add_subtask.dart';
import 'package:delemon_machine_task/features/screen_subtask/presentation/widget/subtask_list.dart';
import 'package:delemon_machine_task/features/screen_task/domain/repository/task_repository.dart';
import 'package:delemon_machine_task/features/screen_subtask/presentation/bloc/subtask_bloc.dart';
import 'package:delemon_machine_task/features/screen_subtask/presentation/bloc/subtask_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../screen_task/domain/entity/task_entity.dart';



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
            Expanded(child: SubtaskList(taskId: task.id)),
          ],
        ),
        floatingActionButton: AddSubtaskButton(taskId: task.id),
      ),
    );
  }
}







