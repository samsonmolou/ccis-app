import 'dart:async';

import 'package:ccis_app/main.dart' as app;
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
void main() {
  app.main(
    userRepository: AnonymousUserRepository(),
    membersInteractor: MembersInteractor(
        ReactiveMembersRepositoryFlutter(
            repository: MembersRepositoryFlutter(
                sqlite: MemberSqlite()))),
    broadcastListsInteractor: BroadcastListInteractor(
        ReactiveBroadcastListsRepositoryFlutter(
            repository: BroadcastListRepositoryFlutter(
                sqlite: BroadcastListSqlite()
            )
        )
    )
  );
}

class AnonymousUserRepository implements UserRepository {
  @override
  Future<UserEntity> login() {
    return Future.value(UserEntity(id: 'anonymous'));
  }
}
