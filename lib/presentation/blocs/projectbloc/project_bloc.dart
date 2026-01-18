import 'package:delemon_machine_task/domain/repository/project_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'project_event.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository repository;

  ProjectBloc(this.repository) : super(ProjectLoading()) {
    on<LoadProjects>(_onLoad);
    on<AddProject>(_onAdd);
    on<ArchiveProject>(_onArchive);
  }

  Future<void> _onLoad(
      LoadProjects event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());
    try {
      final projects = await repository.fetchProjects();
      emit(ProjectLoaded(projects.where((p) => !p.archived).toList()));
    } catch (e) {
      emit(ProjectError('Failed to load projects'));
    }
  }

  Future<void> _onAdd(
      AddProject event, Emitter<ProjectState> emit) async {
    if (state is ProjectLoaded) {
      await repository.createProject(event.project);
      add(LoadProjects());
    }
  }

  Future<void> _onArchive(
      ArchiveProject event, Emitter<ProjectState> emit) async {
    await repository.archiveProject(event.projectId);
    add(LoadProjects());
  }
}
