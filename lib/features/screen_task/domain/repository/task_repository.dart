import '../entity/task_entity.dart';
import '../../../screen_subtask/domain/entity/subtask_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> fetchTasksByProject(String projectId);

  Future<void> createTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String taskId);

  Future<List<SubtaskEntity>> fetchSubtasks(String taskId);
  Future<void> createSubtask(SubtaskEntity subtask);
  Future<void> updateSubtask(SubtaskEntity subtask);
}
