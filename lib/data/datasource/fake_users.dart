import '../../domain/entities/user_entity.dart';
import '../../domain/entities/enums.dart';

final fakeUsers = <UserEntity>[
  const UserEntity(id: 'u1', name: 'Admin', role: UserRole.admin),
  const UserEntity(id: 'u2', name: 'Alice', role: UserRole.staff),
  const UserEntity(id: 'u3', name: 'Bob', role: UserRole.staff),
];
