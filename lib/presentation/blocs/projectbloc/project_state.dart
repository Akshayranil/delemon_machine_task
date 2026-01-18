import 'package:equatable/equatable.dart';
import '../../../../domain/entities/project_entity.dart';

abstract class ProjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProjectLoading extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final List<ProjectEntity> projects;
  ProjectLoaded(this.projects);

  @override
  List<Object?> get props => [projects];
}

class ProjectError extends ProjectState {
  final String message;
  ProjectError(this.message);

  @override
  List<Object?> get props => [message];
}
