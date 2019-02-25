import 'dart:async';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class BroadcastListSqlite {

  const BroadcastListSqlite();

  Future<List<BroadcastListEntity>> getAllBroadcastLists() async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(BroadcastListsMetadata.tableName);
    final broadcastLists = res.isNotEmpty
        ? res
            .map((broadcastList) => BroadcastListEntity.fromJson(broadcastList))
            .toList()
        : [];

    return broadcastLists;
  }


  Future newBroadcastList(BroadcastListEntity newBroadcastList) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.insert(
        BroadcastListsMetadata.tableName, newBroadcastList.toJson());

    return res;
  }

  Future updateBroadcastList(BroadcastListEntity broadcastList) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.update(
        BroadcastListsMetadata.tableName, broadcastList.toJson(),
        where: '''${BroadcastListsMetadata.id} = ?''',
        whereArgs: [broadcastList.id]);

    return res;
  }

  Future deleteBroadcastList(List<String> broadcastListId) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    return await db.delete(BroadcastListsMetadata.tableName,
        where: '''${BroadcastListsMetadata.id} = ?''',
        whereArgs: broadcastListId);
  }


}
