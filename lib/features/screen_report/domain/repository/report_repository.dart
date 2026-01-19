

import 'package:delemon_machine_task/features/screen_report/domain/entity/report_entity.dart';

class ProjectReport {
  final int total;
  final int done;
  final int inProgress;
  final int blocked;
  final int overdue;
  final double completionPercent;
  List<AssigneeOpenTask> openTasksByAssignee;


  ProjectReport({
    required this.total,
    required this.done,
    required this.inProgress,
    required this.blocked,
    required this.overdue,
    required this.completionPercent,
    required this.openTasksByAssignee,
  });
}

abstract class ReportRepository {
  Future<ProjectReport> projectStatus(String projectId);
}
