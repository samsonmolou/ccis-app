import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class MembersRepositoryFlutter implements MembersRepository {
  final MemberFileStorage fileStorage;
  final MemberWebClient webClient;
  final MemberSqlite sqlite;

  const MembersRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const MemberWebClient(),
    this.sqlite = const MemberSqlite(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  @override
  Future<List<MemberEntity>> loadMembers() async {
    try {
      return await fileStorage.loadMembers();
    } catch (e) {
      final members = await webClient.fetchMembers();

      fileStorage.saveMembers(members);

      return members;
    }
  }

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  @override
  Future<List<MemberEntity>> getAllMembers() async {
    try {
      return await sqlite.getAllMembers();
    } catch (e) {
      final members = await webClient.fetchMembers();

      members.forEach((member) => sqlite.newMember(member));

      return members;
    }
  }

  /// Persists members to local disk and the web
  @override
  Future saveMembers(List<MemberEntity> members) {
    return Future.wait<dynamic>([
      fileStorage.saveMembers(members),
      webClient.postMembers(members),
    ]);
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
  Future deleteMember(String memberId) {
    // TODO: implement deleteMember
    return Future.wait<dynamic>([
      sqlite.deleteMember(memberId)
    ]);
  }

}

