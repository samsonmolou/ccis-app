import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:meta/meta.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class RankRepositoryFlutter implements RankRepository {
  final RankMock rankMock;
  final RankSqlite sqlite;

  const RankRepositoryFlutter({
    @required this.sqlite,
    this.rankMock = const RankMock(),
  });

  /// Loads todos first from Sqflite. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  @override
  Future<RankEntity> getRank() async {
    //return await sqlite.getRank();


    try {
      return await sqlite.getRank();
    } catch (e) {
      print(e);
      final rank = await rankMock.fetchRank();
      print(rank);
      sqlite.newRank(rank);
      return rank;
    }
  }

  /// Update member into sqflite member table
  @override
  Future updateRank(RankEntity rank) {
    // TODO: implement updateMember
    return Future.wait<dynamic>([
      sqlite.updateRank(rank)
    ]);
  }
}

