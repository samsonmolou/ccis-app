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

  const MembersRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const MemberWebClient(),
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

  // Persists todos to local disk and the web
  @override
  Future saveMembers(List<MemberEntity> members) {
    return Future.wait<dynamic>([
      fileStorage.saveMembers(members),
      webClient.postMembers(members),
    ]);
  }
}

