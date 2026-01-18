// import 'package:delemon_machine_task/data/datasource/fake_tasks.dart';
// import 'package:delemon_machine_task/domain/repository/report_repository.dart';

// import '../../domain/entities/enums.dart';




// class ReportRepositoryImpl implements ReportRepository {
//   @override
//   Future<ProjectReport> projectStatus(String projectId) async {
//     await Future.delayed(const Duration(milliseconds: 600));

//     final tasks =
//         fakeTasks.where((t) => t.projectId == projectId).toList();

//     final total = tasks.length;
//     final done =
//         tasks.where((t) => t.status == TaskStatus.done).length;
//     final inProgress =
//         tasks.where((t) => t.status == TaskStatus.inProgress).length;
//     final blocked =
//         tasks.where((t) => t.status == TaskStatus.blocked).length;

//     final now = DateTime.now();
//     final overdue = tasks
//         .where((t) => t.status != TaskStatus.done && t.dueDate.isBefore(now))
//         .length;

//     final double completion =
//         total == 0 ? 0 : (done / total) * 100;

//     final Map<String, int> byAssignee = {};

//     for (final task in tasks) {
//       if (task.status == TaskStatus.done) continue;
//       for (final uid in task.assigneeIds) {
//         byAssignee[uid] = (byAssignee[uid] ?? 0) + 1;
//       }
//     }

//     return ProjectReport(
//       total: total,
//       done: done,
//       inProgress: inProgress,
//       blocked: blocked,
//       overdue: overdue,
//       completionPercent: completion,
//       openTasksByAssignee: byAssignee,
//     );
//   }
// }


import 'package:delemon_machine_task/data/datasource/fake_tasks.dart';
import 'package:delemon_machine_task/domain/repository/report_repository.dart';

import '../../domain/entities/enums.dart';




class ReportRepositoryImpl implements ReportRepository {
  @override
  Future<ProjectReport> projectStatus(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final tasks =
        fakeTasks.where((t) => t.projectId == projectId).toList();

    final total = tasks.length;
    final done =
        tasks.where((t) => t.status == TaskStatus.done).length;
    final inProgress =
        tasks.where((t) => t.status == TaskStatus.inProgress).length;
    final blocked =
        tasks.where((t) => t.status == TaskStatus.blocked).length;

    final now = DateTime.now();
    final overdue = tasks
        .where((t) => t.status != TaskStatus.done && t.dueDate.isBefore(now))
        .length;

    final double completion =
        total == 0 ? 0 : (done / total) * 100;

    final Map<String, int> byAssignee = {};

    for (final task in tasks) {
      if (task.status == TaskStatus.done) continue;
      for (final uid in task.assigneeIds) {
        byAssignee[uid] = (byAssignee[uid] ?? 0) + 1;
      }
    }

    return ProjectReport(
      total: total,
      done: done,
      inProgress: inProgress,
      blocked: blocked,
      overdue: overdue,
      completionPercent: completion,
      openTasksByAssignee: byAssignee,
    );
  }
}
