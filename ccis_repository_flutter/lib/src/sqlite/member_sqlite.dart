import 'dart:async';

import 'package:ccis_repository/src/entity/member_entity.dart';
import 'package:ccis_repository_flutter/src/metadata/members_metadata.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class MemberSqlite {

  const MemberSqlite();

  Future<List<MemberEntity>> getAllMembers() async {
    //TODO: Implement Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(MembersMetadata.tableName);
    final members = res.isNotEmpty
        ? res.map((member) => MemberEntity.fromJson(member)).toList()
        : [];

    return members;
  }

  Future newMember(MemberEntity newMember) async {
    //TODO: Implement Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.insert(MembersMetadata.tableName, newMember.toJson());

    return res;
  }

  Future updateMember(MemberEntity member) async {
    //TODO: Implement Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.update(MembersMetadata.tableName, member.toJson(),
        where: '''${MembersMetadata.id} = ?''',
        whereArgs: [member.id]);

    return res;
  }

  Future deleteMember(List<String> memberId) async {
    //TODO: Implement Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    return await db.delete(MembersMetadata.tableName,
        where: '''${MembersMetadata.id} = ?''',
        whereArgs: memberId);
  }
}
