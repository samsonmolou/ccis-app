import 'dart:async';

import 'package:ccis_repository/ccis_repository.dart';

class UserBloc {
  final UserRepository _repository;

  // Outputs
  Stream<UserEntity> login() =>
      _repository.login().asStream().asBroadcastStream();

  UserBloc(UserRepository repository) : this._repository = repository;
}
