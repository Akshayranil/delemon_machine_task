import 'package:delemon_machine_task/domain/repository/report_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'report_event.dart';
import 'report_state.dart';


class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository repository;

  ReportBloc(this.repository) : super(ReportLoading()) {
    on<LoadReport>(_onLoad);
  }

  Future<void> _onLoad(LoadReport event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    try {
      final report = await repository.projectStatus(event.projectId);
      emit(ReportLoaded(report));
    } catch (e) {
      emit(ReportError('Failed to load report'));
    }
  }
}
