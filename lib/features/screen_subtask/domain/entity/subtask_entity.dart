import 'package:equatable/equatable.dart';

class SubtaskEntity extends Equatable {
  final String id;
  final String taskId;
  final String title;
  final bool isDone;
  final String? assigneeId;

  const SubtaskEntity({
    required this.id,
    required this.taskId,
    required this.title,
    required this.isDone,
    this.assigneeId,
  });

  SubtaskEntity copyWith({bool? isDone}) {
    return SubtaskEntity(
      id: id,
      taskId: taskId,
      title: title,
      isDone: isDone ?? this.isDone,
      assigneeId: assigneeId,
    );
  }

  @override
  List<Object?> get props => [id, taskId, title, isDone, assigneeId];
}
