 import 'package:delemon_machine_task/features/screen_project/domain/entity/project_entity.dart';
import 'package:delemon_machine_task/features/screen_project/presentation/projectbloc/project_bloc.dart';
import 'package:delemon_machine_task/features/screen_project/presentation/projectbloc/project_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showAddDialog(BuildContext blocContext) {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: blocContext,
      builder: (_) {
        return AlertDialog(
          title: const Text('New Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(blocContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final project = ProjectEntity(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameCtrl.text,
                  description: descCtrl.text,
                  archived: false,
                );

                blocContext.read<ProjectBloc>().add(AddProject(project));
                Navigator.pop(blocContext);
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }