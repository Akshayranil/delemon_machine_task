import 'package:equatable/equatable.dart';
import '../../../domain/entities/subtask_entity.dart';

abstract class SubtaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSubtasks extends SubtaskEvent {
  final String taskId;
  LoadSubtasks(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class ToggleSubtask extends SubtaskEvent {
  final SubtaskEntity subtask;
  ToggleSubtask(this.subtask);

  @override
  List<Object?> get props => [subtask];
}

class AddSubtask extends SubtaskEvent {
  final SubtaskEntity subtask;
  AddSubtask(this.subtask);

  @override
  List<Object?> get props => [subtask];
}
