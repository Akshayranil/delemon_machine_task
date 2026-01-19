

import 'package:delemon_machine_task/features/screen_report/domain/entity/report_entity.dart';



abstract class ReportRepository {
  Future<ProjectReport> projectStatus(String projectId);
}
