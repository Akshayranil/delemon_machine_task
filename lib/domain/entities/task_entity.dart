import 'package:equatable/equatable.dart';
import 'enums.dart';

class TaskEntity extends Equatable {
  final String id;
  final String projectId;
  final String title;
  final String description;

  final TaskStatus status;
  final TaskPriority priority;

  final DateTime startDate;
  final DateTime dueDate;

  final double estimateHours;
  final double timeSpentHours;

  final List<String> assigneeIds;
  final List<String> labels;

  const TaskEntity({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.startDate,
    required this.dueDate,
    required this.estimateHours,
    required this.timeSpentHours,
    required this.assigneeIds,
    required this.labels,
  });

  TaskEntity copyWith({
    TaskStatus? status,
    double? timeSpentHours,
    List<String>? assigneeIds,
  }) {
    return TaskEntity(
      id: id,
      projectId: projectId,
      title: title,
      description: description,
      status: status ?? this.status,
      priority: priority,
      startDate: startDate,
      dueDate: dueDate,
      estimateHours: estimateHours,
      timeSpentHours: timeSpentHours ?? this.timeSpentHours,
      assigneeIds: assigneeIds ?? this.assigneeIds,
      labels: labels,
    );
  }

  @override
  List<Object?> get props => [
        id,
        projectId,
        title,
        description,
        status,
        priority,
        startDate,
        dueDate,
        estimateHours,
        timeSpentHours,
        assigneeIds,
        labels,
      ];
}
