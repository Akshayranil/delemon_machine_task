import 'package:equatable/equatable.dart';
import '../../../domain/entities/subtask_entity.dart';

abstract class SubtaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubtaskLoading extends SubtaskState {}

class SubtaskLoaded extends SubtaskState {
  final List<SubtaskEntity> subtasks;
  SubtaskLoaded(this.subtasks);

  @override
  List<Object?> get props => [subtasks];
}

class SubtaskError extends SubtaskState {
  final String message;
  SubtaskError(this.message);

  @override
  List<Object?> get props => [message];
}
