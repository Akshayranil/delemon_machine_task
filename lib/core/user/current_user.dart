
import 'package:delemon_machine_task/core/user/fake_users.dart';

import 'user_entity.dart';

/// Change this to simulate which user is logged in
/// fakeUsers[0] -> Admin
/// fakeUsers[1] -> Staff Alice
/// fakeUsers[2] -> Staff Bob
UserEntity currentUser = fakeUsers[0]; // Admin by default
