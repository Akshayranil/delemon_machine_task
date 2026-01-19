import 'dart:async';

import 'package:delemon_machine_task/features/screen_project/data/datasource/fake_projects.dart';
import 'package:delemon_machine_task/features/screen_project/domain/repository/project_repository.dart';

import '../../domain/entity/project_entity.dart';


class ProjectRepositoryImpl implements ProjectRepository {
  final _projects = fakeProjects;

  @override
  Future<List<ProjectEntity>> fetchProjects() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.from(_projects);
  }

  @override
  Future<void> createProject(ProjectEntity project) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _projects.add(project);
  }

  @override
  Future<void> updateProject(ProjectEntity project) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) _projects[index] = project;
  }

  @override
  Future<void> archiveProject(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _projects.indexWhere((p) => p.id == projectId);
    if (index != -1) {
      _projects[index] = _projects[index].copyWith(archived: true);
    }
  }
}
