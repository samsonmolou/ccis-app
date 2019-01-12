import 'dart:async';

import 'package:ccis_repository/src/entity/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> login();
}