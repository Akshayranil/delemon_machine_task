import 'package:delemon_machine_task/core/user/current_user.dart';
import 'package:delemon_machine_task/domain/entities/enums.dart';
import 'package:delemon_machine_task/domain/repository/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/entities/task_entity.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskState.initial()) {
    on<LoadTasks>(_onLoad);
    on<ApplyFilters>(_onFilter);
    on<UpdateTask>(_onUpdate);
  }

  // Future<void> _onLoad(LoadTasks event, Emitter<TaskState> emit) async {
  //   emit(state.copyWith(loading: true));

  //   final tasks = await repository.fetchTasksByProject(event.projectId);

  //   emit(state.copyWith(
  //     all: tasks,
  //     filtered: tasks,
  //     loading: false,
  //   ));
  // }

  Future<void> _onLoad(LoadTasks event, Emitter<TaskState> emit) async {
  emit(state.copyWith(loading: true));

  final tasks = await repository.fetchTasksByProject(event.projectId);

  // Filter tasks for staff
  final visibleTasks = currentUser.role == UserRole.admin
      ? tasks // Admin sees all
      : tasks.where((t) => t.assigneeIds.contains(currentUser.id)).toList();

  emit(state.copyWith(
    all: visibleTasks,
    filtered: visibleTasks,
    loading: false,
  ));
}


  void _onFilter(ApplyFilters event, Emitter<TaskState> emit) {
    Iterable<TaskEntity> result = state.all;

    if (event.status != null) {
      result = result.where((t) => t.status == event.status);
    }

    if (event.priority != null) {
      result = result.where((t) => t.priority == event.priority);
    }

    if (event.assigneeId != null) {
      result = result.where((t) => t.assigneeIds.contains(event.assigneeId));
    }

    if (event.search.isNotEmpty) {
      final q = event.search.toLowerCase();
      result = result.where((t) =>
          t.title.toLowerCase().contains(q) ||
          t.description.toLowerCase().contains(q));
    }

    emit(state.copyWith(
      filtered: result.toList(),
      status: event.status,
      priority: event.priority,
      assigneeId: event.assigneeId,
      search: event.search,
    ));
  }

  Future<void> _onUpdate(UpdateTask event, Emitter<TaskState> emit) async {
    await repository.updateTask(event.task);

    final updated = state.all.map((t) {
      return t.id == event.task.id ? event.task : t;
    }).toList();

    emit(state.copyWith(all: updated, filtered: updated));
  }
}
