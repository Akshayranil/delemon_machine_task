import 'package:equatable/equatable.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/entities/enums.dart';

class TaskState extends Equatable {
  final List<TaskEntity> all;
  final List<TaskEntity> filtered;

  final TaskStatus? status;
  final TaskPriority? priority;
  final String? assigneeId;
  final String search;

  final bool loading;

  const TaskState({
    required this.all,
    required this.filtered,
    this.status,
    this.priority,
    this.assigneeId,
    this.search = '',
    this.loading = false,
  });

  factory TaskState.initial() => const TaskState(
        all: [],
        filtered: [],
        loading: true,
      );

  TaskState copyWith({
    List<TaskEntity>? all,
    List<TaskEntity>? filtered,
    TaskStatus? status,
    TaskPriority? priority,
    String? assigneeId,
    String? search,
    bool? loading,
  }) {
    return TaskState(
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assigneeId: assigneeId ?? this.assigneeId,
      search: search ?? this.search,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props =>
      [all, filtered, status, priority, assigneeId, search, loading];
}
