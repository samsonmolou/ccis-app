import 'dart:async';

import 'package:ccis_app/main.dart' as app;
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  app.main(
    membersInteractor: MembersInteractor(ReactiveMembersRepositoryFlutter(
        repository: MembersRepositoryFlutter(
            fileStorage: MemberFileStorage(
      '__bloc_local_storage',
      getApplicationDocumentsDirectory,
    )))),
    userRepository: AnonymousUserRepository(),
  );
}

class AnonymousUserRepository implements UserRepository {
  @override
  Future<UserEntity> login() {
    return Future.value(UserEntity(id: 'anonymous'));
  }
}
