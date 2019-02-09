import 'dart:async';

import 'package:ccis_app/main.dart' as app;
import 'package:ccis_repository/ccis_repository.dart';

void main() {
  app.main(
    userRepository: AnonymousUserRepository(),
  );
}

class AnonymousUserRepository implements UserRepository {
  @override
  Future<UserEntity> login() {
    return Future.value(UserEntity(id: 'anonymous'));
  }
}
