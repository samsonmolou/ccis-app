import 'dart:async';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class BroadcastSqlite {

  const BroadcastSqlite();

  Future<List<BroadcastEntity>> getAllBroadcasts() async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(BroadcastsMetadata.tableName);
    final broadcasts = res.isNotEmpty
        ? res
        .map((broadcast) => BroadcastEntity.fromJson(broadcast))
        .toList()
        : [];

    return broadcasts;
  }


  Future newBroadcast(BroadcastEntity newBroadcast) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.insert(
        BroadcastsMetadata.tableName, newBroadcast.toJson());

    return res;
  }

  Future updateBroadcast(BroadcastEntity broadcast) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.update(
        BroadcastsMetadata.tableName, broadcast.toJson(),
        where: '''${BroadcastsMetadata.id} = ?''',
        whereArgs: [broadcast.id]);

    return res;
  }

  Future deleteBroadcast(List<String> broadcastId) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    return await db.delete(BroadcastsMetadata.tableName,
        where: '''${BroadcastsMetadata.id} = ?''',
        whereArgs: broadcastId);
  }


}
