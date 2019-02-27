import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/src/entity/broadcast_list_member_entity.dart';

/// A class that Loads broadcast from database file. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as study_repository_flutter or study_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class BroadcastListMembersRepository {
  /// Loads broadcast list from database
  Future<List<BroadcastListMemberEntity>> getAllBroadcastListMembers();

  /// Persists broadcast list to sqflite corresponding table
  Future newBroadcastListMember(BroadcastListMemberEntity broadcastListMember);

  /// Update broadcast list to sqflite corresponding table
  Future updateBroadcastListMember(BroadcastListMemberEntity broadcastListMember);

  /// Delete broadcast list to sqflite corresponding table
  Future deleteBroadcastListMember(List<String> broadcastListMemberId);

  /// Get broadcast list member match with broadcast list id
  Future<List<BroadcastListMemberEntity>> getBroadcastListMembersByBroadcastListId(String broadcastListId);

  /// Get broadcast list member match with member id
  Future<List<BroadcastListMemberEntity>> getBroadcastListMembersByMemberId(String memberId);
}
