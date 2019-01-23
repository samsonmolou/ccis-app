import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:ccis_repository/src/entity/member_entity.dart';


/// A data layer class works with reactive data sources, such as Firebase. This
/// class emits a Stream of TodoEntities. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as firebase_repository_flutter.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class ReactiveMembersRepository {
  Future<void> addNewMember(MemberEntity member);

  Future<void> deleteMember(List<String> idList);

  Stream<List<MemberEntity>> members();

  Future<void> updateMember(MemberEntity member);
}
