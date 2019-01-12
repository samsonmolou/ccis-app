import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/src/entity/member_entity.dart';

/// A class that Loads and Persists members. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as members_repository_flutter or members_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class MembersRepository {
  /// Loads members first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  Future<List<MemberEntity>> loadMembers();

  // Persists todos to local disk and the web
  Future saveMembers(List<MemberEntity> members);
}