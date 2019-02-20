import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:meta/meta.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class BroadcastListRepositoryFlutter implements BroadcastListRepository {
  final BroadcastListMock broadcastListMock;
  final BroadcastListSqlite sqlite;

  const BroadcastListRepositoryFlutter({
    @required this.sqlite,
    this.broadcastListMock = const BroadcastListMock(),
  });


  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  @override
  Future<List<BroadcastListEntity>> getAllBroadcastLists() async {
    try {
      return await sqlite.getAllBroadcastLists();
    } catch (e) {
      final broadcastLists = await broadcastListMock.fetchBroadcastLists();

      broadcastLists.forEach((broadcastList) => sqlite.newBroadcastList(broadcastList));

      return broadcastLists;
    }
  }


  /// Persists members to sqflite member table
  @override
  Future newBroadcastList(BroadcastListEntity broadcastList) {
    return Future.wait<dynamic>([
      sqlite.newBroadcastList(broadcastList)
    ]);
  }

  /// Update member into sqflite member table
  @override
  Future updateBroadcastList(BroadcastListEntity broadcastList) {
    return Future.wait<dynamic>([
      sqlite.updateBroadcastList(broadcastList)
    ]);
  }

  /// Delete member info sqflite member table
  @override
  Future deleteBroadcastList(List<String> broadcastListId) {
    return Future.wait<dynamic>([
      sqlite.deleteBroadcastList(broadcastListId)
    ]);
  }

}

