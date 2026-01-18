import 'dart:async';

import 'package:delemon_machine_task/data/datasource/fake_subtasks.dart';
import 'package:delemon_machine_task/data/datasource/fake_tasks.dart';
import 'package:delemon_machine_task/domain/repository/task_repository.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/entities/subtask_entity.dart';


class TaskRepositoryImpl implements TaskRepository {
  final _tasks = fakeTasks;
  final _subtasks = fakeSubtasks;

  @override
  Future<List<TaskEntity>> fetchTasksByProject(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return _tasks.where((t) => t.projectId == projectId).toList();
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _tasks.add(task);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) _tasks[index] = task;
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _tasks.removeWhere((t) => t.id == taskId);
    _subtasks.removeWhere((s) => s.taskId == taskId);
  }

  @override
  Future<List<SubtaskEntity>> fetchSubtasks(String taskId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _subtasks.where((s) => s.taskId == taskId).toList();
  }

  @override
  Future<void> createSubtask(SubtaskEntity subtask) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _subtasks.add(subtask);
  }

  @override
  Future<void> updateSubtask(SubtaskEntity subtask) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _subtasks.indexWhere((s) => s.id == subtask.id);
    if (index != -1) _subtasks[index] = subtask;
  }
}
