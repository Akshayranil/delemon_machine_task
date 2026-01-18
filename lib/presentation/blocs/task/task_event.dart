import 'package:equatable/equatable.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {
  final String projectId;
  LoadTasks(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class UpdateTask extends TaskEvent {
  final TaskEntity task;
  UpdateTask(this.task);

  @override
  List<Object?> get props => [task];
}

class ApplyFilters extends TaskEvent {
  final TaskStatus? status;
  final TaskPriority? priority;
  final String? assigneeId;
  final String search;

  ApplyFilters({
    this.status,
    this.priority,
    this.assigneeId,
    this.search = '',
  });

  @override
  List<Object?> get props => [status, priority, assigneeId, search];
}
