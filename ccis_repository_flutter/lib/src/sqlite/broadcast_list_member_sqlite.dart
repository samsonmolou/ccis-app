import 'dart:async';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class BroadcastListMemberSqlite {
  const BroadcastListMemberSqlite();

  Future<List<BroadcastListMemberEntity>> getAllBroadcastListMembers() async {
    //TODO: implement demeter law for less coupling between DBProvider and this
    Database db = await DBProvider.provider.database;
    var res = await db.query(BroadcastListMembersMetadata.tableName);
    final broadcastListMembers = res.isNotEmpty
        ? res
            .map((broadcastListMember) =>
                BroadcastListMemberEntity.fromJson(broadcastListMember))
            .toList()
        : [];

    return broadcastListMembers;
  }

  Future newBroadcastListMember(
      BroadcastListMemberEntity newBroadcastListMember) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.insert(BroadcastListMembersMetadata.tableName,
        newBroadcastListMember.toJson());

    return res;
  }

  Future updateBroadcastListMember(
      BroadcastListMemberEntity broadcastListMember) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.update(BroadcastListMembersMetadata.tableName,
        broadcastListMember.toJson(),
        where: '''${BroadcastListMembersMetadata.id} = ?''',
        whereArgs: [broadcastListMember.id]);

    return res;
  }

  Future deleteBroadcastListMember(List<String> broadcastListMemberId) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    return await db.delete(BroadcastListMembersMetadata.tableName,
        where: '''${BroadcastListMembersMetadata.id} = ?''',
        whereArgs: broadcastListMemberId);
  }

  Future<List<BroadcastListMemberEntity>>
      getBroadcastListMembersByBroadcastListId(String broadcastListId) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(BroadcastListMembersMetadata.tableName,
        where:
            '''${BroadcastListMembersMetadata.broadcastListId} = ?''',
        whereArgs: [broadcastListId]);
    final broadcastListMembersByBroadcastId = res.isNotEmpty
        ? res
            .map((broadcastListMember) =>
                BroadcastListMemberEntity.fromJson(broadcastListMember))
            .toList()
        : [];

    return broadcastListMembersByBroadcastId;
  }

  Future<List<BroadcastListMemberEntity>> getBroadcastListMembersByMemberId(
      String memberId) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(BroadcastListMembersMetadata.tableName,
        where:
            '''${BroadcastListMembersMetadata.memberId} = ?''',
        whereArgs: [memberId]);
    final broadcastListMembersByMemberId = res.isNotEmpty
        ? res
            .map((broadcastListMember) =>
                BroadcastListMemberEntity.fromJson(broadcastListMember))
            .toList()
        : [];

    return broadcastListMembersByMemberId;
  }
}
