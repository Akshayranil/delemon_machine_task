import 'package:delemon_machine_task/features/screen_report/domain/repository/report_repository.dart';
import 'package:equatable/equatable.dart';


abstract class ReportState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final ProjectReport report;
  ReportLoaded(this.report);

  @override
  List<Object?> get props => [report];
}

class ReportError extends ReportState {
  final String message;
  ReportError(this.message);

  @override
  List<Object?> get props => [message];
}
