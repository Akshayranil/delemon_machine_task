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


// import 'package:delemon_machine_task/features/screen_task/data/datasource/fake_tasks.dart';
// import 'package:delemon_machine_task/features/screen_report/domain/repository/report_repository.dart';

// import '../../../../core/enums/enums.dart';


//in this code the username is not getten

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


import 'package:delemon_machine_task/core/user/fake_users.dart';
import 'package:delemon_machine_task/features/screen_report/domain/entity/report_entity.dart';
import 'package:delemon_machine_task/features/screen_report/domain/repository/report_repository.dart';
import 'package:delemon_machine_task/features/screen_task/data/datasource/fake_tasks.dart';

import '../../../../core/enums/enums.dart';

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

    // -------- Map userId -> username --------

    final userNameById = {
      for (final u in fakeUsers) u.id: u.name,
    };

    // -------- Count open tasks per user --------

    final Map<String, int> countByUserId = {};

    for (final task in tasks) {
      if (task.status == TaskStatus.done) continue;

      for (final uid in task.assigneeIds) {
        countByUserId[uid] = (countByUserId[uid] ?? 0) + 1;
      }
    }

    // -------- Build AssigneeOpenTask List --------

    final List<AssigneeOpenTask> assigneeList =
        countByUserId.entries.map((e) {
      return AssigneeOpenTask(
        userId: e.key,
        username: userNameById[e.key] ?? 'Unknown',
        openCount: e.value,
      );
    }).toList();

    return ProjectReport(
      total: total,
      done: done,
      inProgress: inProgress,
      blocked: blocked,
      overdue: overdue,
      completionPercent: completion,
      openTasksByAssignee: assigneeList,
    );
  }
}


