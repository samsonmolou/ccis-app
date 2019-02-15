import 'dart:async';

import 'package:ccis_repository/src/entity/broadcast_list_member_entity.dart';
import 'package:ccis_repository_flutter/src/metadata/database_metadata.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class BroadcastListMemberSqlite {

  const BroadcastListMemberSqlite();

  Future<List<BroadcastListMemberEntity>> getAllBroadcastListMembers() async {
    //TODO: implement demeter law for less coupling between DBProvider and this
    Database db = await DBProvider.provider.database;
    var res = await db.query(DatabaseMetadata.tableBroadcastListsMembers);
    final broadcastListMembers = res.isNotEmpty
        ? res
        .map((broadcastListMember) => BroadcastListMemberEntity.fromJson(broadcastListMember))
        .toList()
        : [];

    return broadcastListMembers;
  }

  Future newBroadcastListMember(BroadcastListMemberEntity newBroadcastListMember) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.insert(
        DatabaseMetadata.tableBroadcastListsMembers, newBroadcastListMember.toJson());

    return res;
  }

  Future updateBroadcastListMember(BroadcastListMemberEntity broadcastListMember) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.update(
        DatabaseMetadata.tableBroadcastListsMembers, broadcastListMember.toJson(),
        where: '''${DatabaseMetadata.columnBroadcastListsMembersId} = ?''',
        whereArgs: [broadcastListMember.id]);

    return res;
  }

  Future deleteBroadcastListMember(List<String> broadcastListMemberId) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    return await db.delete(DatabaseMetadata.tableBroadcastListsMembers,
        where: '''${DatabaseMetadata.columnBroadcastListsMembersId} = ?''',
        whereArgs: broadcastListMemberId);
  }

  Future<List<BroadcastListMemberEntity>> getBroadcastListMembersByBroadcastListId(String broadcastListId) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(DatabaseMetadata.tableBroadcastListsMembers,
        where: '''${DatabaseMetadata.columnBroadcastListsMembersBroadcastListId} = ?''',
        whereArgs: [broadcastListId]);
    final broadcastListMembersByBroadcastId = res.isNotEmpty
        ? res
        .map((broadcastListMember) => BroadcastListMemberEntity.fromJson(broadcastListMember))
        .toList()
        : [];

    return broadcastListMembersByBroadcastId;
  }

  Future<List<BroadcastListMemberEntity>> getBroadcastListMembersByMemberId(String memberId) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(DatabaseMetadata.tableBroadcastListsMembers,
        where: '''${DatabaseMetadata.columnBroadcastListsMembersMemberId} = ?''',
        whereArgs: [memberId]);
    final broadcastListMembersByMemberId = res.isNotEmpty
        ? res
        .map((broadcastListMember) => BroadcastListMemberEntity.fromJson(broadcastListMember))
        .toList()
        : [];

    return broadcastListMembersByMemberId;
  }
}
