import '../../domain/entities/subtask_entity.dart';

final fakeSubtasks = <SubtaskEntity>[
  SubtaskEntity(
    id: 's1',
    taskId: 't2',
    title: 'Create DTO models',
    isDone: true,
  ),
  SubtaskEntity(
    id: 's2',
    taskId: 't2',
    title: 'API service class',
    isDone: false,
  ),
  SubtaskEntity(
    id: 's3',
    taskId: 't3',
    title: 'Design layout',
    isDone: false,
  ),
];
