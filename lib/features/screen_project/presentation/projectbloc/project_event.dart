import 'package:equatable/equatable.dart';
import '../../domain/entity/project_entity.dart';

abstract class ProjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProjects extends ProjectEvent {}

class AddProject extends ProjectEvent {
  final ProjectEntity project;
  AddProject(this.project);

  @override
  List<Object?> get props => [project];
}

class ArchiveProject extends ProjectEvent {
  final String projectId;
  ArchiveProject(this.projectId);

  @override
  List<Object?> get props => [projectId];
}
