import 'package:delemon_machine_task/features/screen_task/domain/repository/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import 'subtask_event.dart';
import 'subtask_state.dart';

class SubtaskBloc extends Bloc<SubtaskEvent, SubtaskState> {
  final TaskRepository repository;

  SubtaskBloc(this.repository) : super(SubtaskLoading()) {
    on<LoadSubtasks>(_onLoad);
    on<ToggleSubtask>(_onToggle);
    on<AddSubtask>(_onAdd);
  }

  Future<void> _onLoad(
      LoadSubtasks event, Emitter<SubtaskState> emit) async {
    emit(SubtaskLoading());
    try {
      final list = await repository.fetchSubtasks(event.taskId);
      emit(SubtaskLoaded(list));
    } catch (e) {
      emit(SubtaskError('Failed to load subtasks'));
    }
  }

  Future<void> _onToggle(
      ToggleSubtask event, Emitter<SubtaskState> emit) async {
    if (state is SubtaskLoaded) {
      final updated = event.subtask.copyWith(
        isDone: !event.subtask.isDone,
      );

      await repository.updateSubtask(updated);

      add(LoadSubtasks(event.subtask.taskId));
    }
  }

  Future<void> _onAdd(
      AddSubtask event, Emitter<SubtaskState> emit) async {
    await repository.createSubtask(event.subtask);
    add(LoadSubtasks(event.subtask.taskId));
  }
}
