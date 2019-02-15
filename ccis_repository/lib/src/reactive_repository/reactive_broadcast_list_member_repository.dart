import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/src/entity/broadcast_list_member_entity.dart';

/// A data layer class works with reactive data sources, such as Firebase. This
/// class emits a Stream of MembersEntities. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as firebase_repository_flutter.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class ReactiveBroadcastListMemberRepository {
  /// Loads broadcast list from database
  Stream<List<BroadcastListMemberEntity>> broadcastListMembers();

  /// Persists broadcast list to sqflite corresponding table
  Future addNewBroadcastListMember(BroadcastListMemberEntity broadcastListMember);

  /// Update broadcast list to sqflite corresponding table
  Future updateBroadcastListMember(BroadcastListMemberEntity broadcastListMember);

  /// Delete broadcast list to sqflite corresponding table
  Future deleteBroadcastListMember(List<String> broadcastListId);

  /// Get broadcast list member by broadcastlistId
  Stream<List<BroadcastListMemberEntity>> broadcastListMembersByBroadcastListId(String broadcastListId);

  /// Get broadcast list member by memberId
  Stream<List<BroadcastListMemberEntity>> broadcastListMembersByMemberId(String memberId);
}
