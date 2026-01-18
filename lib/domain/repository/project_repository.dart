import '../entities/project_entity.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntity>> fetchProjects();
  Future<void> createProject(ProjectEntity project);
  Future<void> updateProject(ProjectEntity project);
  Future<void> archiveProject(String projectId);
}
