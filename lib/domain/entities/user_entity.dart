import 'package:equatable/equatable.dart';
import 'enums.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final UserRole role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, role];
}
