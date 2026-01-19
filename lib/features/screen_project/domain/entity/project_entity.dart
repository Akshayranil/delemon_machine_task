import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool archived;

  const ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.archived,
  });

  ProjectEntity copyWith({
    String? id,
    String? name,
    String? description,
    bool? archived,
  }) {
    return ProjectEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      archived: archived ?? this.archived,
    );
  }

  @override
  List<Object?> get props => [id, name, description, archived];
}
