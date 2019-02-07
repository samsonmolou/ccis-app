import 'dart:async';

import 'package:ccis_repository/src/entity/member_entity.dart';
import 'package:ccis_repository_flutter/src/keys/database_keys.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';


class MemberSqlite {

  const MemberSqlite();

  Future<List<MemberEntity>> getAllMembers() async {
    Database db = await DBProvider.provider.database;
    var res = await db.query(tableMember);
    final members = res.isNotEmpty
        ? res.map((member) => MemberEntity.fromJson(member)).toList()
        : []
    ;

    return members;
  }

  Future newMember(MemberEntity newMember) async {

    Database db = await DBProvider.provider.database;
    var res = await db.insert(tableMember, newMember.toJson());

    return res;
  }

  Future updateMember(MemberEntity member) async {
    Database db = await DBProvider.provider.database;
    var res = await db.update(tableMember, member.toJson(),
      where: '''$columnMemberId = ?''', whereArgs: [member.id]
    );

    return res;
  }

  Future deleteMember(String memberId) async {
    Database db = await DBProvider.provider.database;
    return db.delete(tableMember, where: '''$columnMemberId = ?''', whereArgs: [memberId]);
  }
}