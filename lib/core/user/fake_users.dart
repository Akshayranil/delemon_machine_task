import 'user_entity.dart';
import '../enums/enums.dart';

final fakeUsers = <UserEntity>[
  const UserEntity(id: 'u1', name: 'Admin', role: UserRole.admin),
  const UserEntity(id: 'u2', name: 'Akshay', role: UserRole.staff),
  const UserEntity(id: 'u3', name: 'Arjun', role: UserRole.staff),
];
