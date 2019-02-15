import 'dart:async';

import 'package:ccis_repository/src/entity/broadcast_list_entity.dart';
import 'package:ccis_repository_flutter/src/metadata/database_metadata.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class BroadcastListSqlite {

  const BroadcastListSqlite();

  Future<List<BroadcastListEntity>> getAllBroadcastLists() async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(DatabaseMetadata.tableBroadcastList);
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
        DatabaseMetadata.tableBroadcastList, newBroadcastList.toJson());

    return res;
  }

  Future updateBroadcastList(BroadcastListEntity broadcastList) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.update(
        DatabaseMetadata.tableBroadcastList, broadcastList.toJson(),
        where: '''${DatabaseMetadata.columnBroadcastListId} = ?''',
        whereArgs: [broadcastList.id]);

    return res;
  }

  Future deleteBroadcastList(List<String> broadcastListId) async {
    //TODO: implement demeter law for less coupling
    Database db = await DBProvider.provider.database;
    return await db.delete(DatabaseMetadata.tableMember,
        where: '''${DatabaseMetadata.columnBroadcastListId} = ?''',
        whereArgs: broadcastListId);
  }


}
