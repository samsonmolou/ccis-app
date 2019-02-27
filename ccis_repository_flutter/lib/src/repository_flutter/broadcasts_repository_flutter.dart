import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:meta/meta.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class BroadcastsRepositoryFlutter implements BroadcastsRepository {
  final BroadcastMock broadcastMock;
  final BroadcastSqlite sqlite;

  const BroadcastsRepositoryFlutter({
    @required this.sqlite,
    this.broadcastMock = const BroadcastMock(),
  });


  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  @override
  Future<List<BroadcastEntity>> getAllBroadcasts() async {

    try {
      return await sqlite.getAllBroadcasts();
    } catch (e) {
      print(e);
      final broadcasts = await broadcastMock.fetchBroadcasts();

      broadcasts.forEach((broadcast) => sqlite.newBroadcast(broadcast));

      return broadcasts;
    }
  }


  /// Persists members to sqflite member table
  @override
  Future newBroadcast(BroadcastEntity broadcast) {
    return Future.wait<dynamic>([
      sqlite.newBroadcast(broadcast)
    ]);
  }

  /// Update member into sqflite member table
  @override
  Future updateBroadcast(BroadcastEntity broadcast) {
    return Future.wait<dynamic>([
      sqlite.updateBroadcast(broadcast)
    ]);
  }

  /// Delete member info sqflite member table
  @override
  Future deleteBroadcast(List<String> broadcastId) {
    return Future.wait<dynamic>([
      sqlite.deleteBroadcast(broadcastId)
    ]);
  }

}

