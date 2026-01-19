class AssigneeOpenTask {
  final String userId;
  final String username;
  final int openCount;

  AssigneeOpenTask({
    required this.userId,
    required this.username,
    required this.openCount,
  });
}


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