import 'dart:async';

import 'package:ccis_repository/src/entity/member_entity.dart';
import 'package:ccis_repository_flutter/src/database_metadata/database_metadata.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class MemberSqlite {
  const MemberSqlite();

  Future<List<MemberEntity>> getAllMembers() async {
    Database db = await DBProvider.provider.database;
    var res = await db.query(DatabaseMetadata.tableMember);
    final members = res.isNotEmpty
        ? res.map((member) => MemberEntity.fromJson(member)).toList()
        : [];

    return members;
  }

  Future newMember(MemberEntity newMember) async {
    Database db = await DBProvider.provider.database;
    var res = await db.insert(DatabaseMetadata.tableMember, newMember.toJson());

    return res;
  }

  Future updateMember(MemberEntity member) async {
    Database db = await DBProvider.provider.database;
    var res = await db.update(DatabaseMetadata.tableMember, member.toJson(),
        where: '''${DatabaseMetadata.columnMemberId} = ?''',
        whereArgs: [member.id]);

    return res;
  }

  Future deleteMember(List<String> memberId) async {
    Database db = await DBProvider.provider.database;
    return db.delete(DatabaseMetadata.tableMember,
        where: '''${DatabaseMetadata.columnMemberId} = ?''',
        whereArgs: memberId);
  }
}
