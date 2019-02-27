import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:meta/meta.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class MembersRepositoryFlutter implements MembersRepository {
  final MemberMock memberMock;
  final MemberSqlite sqlite;

  const MembersRepositoryFlutter({
    @required this.sqlite,
    this.memberMock = const MemberMock(),
  });

  /// Loads todos first from Sqflite. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  @override
  Future<List<MemberEntity>> getAllMembers() async {
    //return await sqlite.getAllMembers();

    try {
      return await sqlite.getAllMembers();
    } catch (e) {
      print(e);
      final members = await memberMock.fetchMembers();

      members.forEach((member) => sqlite.newMember(member));

      return members;
    }
  }


  /// Persists members to sqflite member table
  @override
  Future newMember(MemberEntity member) {
    // TODO: implement newMember
    return Future.wait<dynamic>([
      sqlite.newMember(member)
    ]);
  }

  /// Update member into sqflite member table
  @override
  Future updateMember(MemberEntity member) {
    // TODO: implement updateMember
    return Future.wait<dynamic>([
      sqlite.updateMember(member)
    ]);
  }

  /// Delete member info sqflite member table
  @override
  Future deleteMember(List<String> memberId) {
    // TODO: implement deleteMember
    return Future.wait<dynamic>([
      sqlite.deleteMember(memberId)
    ]);
  }

}

