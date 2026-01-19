import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadReport extends ReportEvent {
  final String projectId;
  LoadReport(this.projectId);

  @override
  List<Object?> get props => [projectId];
}
