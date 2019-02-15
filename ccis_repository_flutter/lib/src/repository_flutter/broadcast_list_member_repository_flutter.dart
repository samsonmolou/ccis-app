import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:meta/meta.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class BroadcastListMemberRepositoryFlutter implements BroadcastListMemberRepository {
  final BroadcastListMemberMock broadcastListMemberMock;
  final BroadcastListMemberSqlite sqlite;

  const BroadcastListMemberRepositoryFlutter({
    @required this.sqlite,
    this.broadcastListMemberMock = const BroadcastListMemberMock(),
  });


  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  @override
  Future<List<BroadcastListMemberEntity>> getAllBroadcastListMembers() async {
    try {
      return await sqlite.getAllBroadcastListMembers();
    } catch (e) {
      final broadcastListMembers = await broadcastListMemberMock.fetchBroadcastListMembers();

      broadcastListMembers.forEach((broadcastListMember) => sqlite.newBroadcastListMember(broadcastListMember));

      return broadcastListMembers;
    }
  }


  /// Persists members to sqflite member table
  @override
  Future newBroadcastListMember(BroadcastListMemberEntity broadcastListMember) {
    return Future.wait<dynamic>([
      sqlite.newBroadcastListMember(broadcastListMember)
    ]);
  }

  /// Update broadcast list into sqflite broadcast list table
  @override
  Future updateBroadcastListMember(BroadcastListMemberEntity broadcastListMember) {
    return Future.wait<dynamic>([
      sqlite.updateBroadcastListMember(broadcastListMember)
    ]);
  }

  /// Delete broadcast list member in sqflite database
  @override
  Future deleteBroadcastListMember(List<String> broadcastListMemberId) {
    return Future.wait<dynamic>([
      sqlite.deleteBroadcastListMember(broadcastListMemberId)
    ]);
  }

  @override
  Future<List<BroadcastListMemberEntity>> getBroadcastListMembersByBroadcastListId(String broadcastListId) {
    return Future.wait<dynamic>([
      sqlite.getBroadcastListMembersByBroadcastListId(broadcastListId)
    ]);
  }

  @override
  Future<List<BroadcastListMemberEntity>> getBroadcastListMembersByMemberId(String memberId) {
    return Future.wait<dynamic>([
      sqlite.getBroadcastListMembersByMemberId(memberId)
    ]);
  }
}

