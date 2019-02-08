import 'dart:async';

import 'package:ccis_repository/src/entity/broadcast_list_entity.dart';
import 'package:ccis_repository_flutter/src/database_metadata/database_metadata.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

class BroadcastListSqlite {
  final Database db;
  const BroadcastListSqlite({@required this.db});

  Future<List<BroadcastListEntity>> getAllBroadcastLists() async {
    //Database db = await DBProvider.provider.database;
    var res = await this.db.query(DatabaseMetadata.tableBroadcastList);
    final broadcastLists = res.isNotEmpty
        ? res
            .map((broadcastList) => BroadcastListEntity.fromJson(broadcastList))
            .toList()
        : [];

    return broadcastLists;
  }

  Future newBroadcastList(BroadcastListEntity newBroadcastList) async {
    //Database db = await DBProvider.provider.database;
    var res = await this.db.insert(
        DatabaseMetadata.tableBroadcastList, newBroadcastList.toJson());

    return res;
  }

  Future updateBroadcastList(BroadcastListEntity broadcastList) async {
    //Database db = await DBProvider.provider.database;
    var res = await this.db.update(
        DatabaseMetadata.tableBroadcastList, broadcastList.toJson(),
        where: '''${DatabaseMetadata.columnBroadcastListId} = ?''',
        whereArgs: [broadcastList.id]);

    return res;
  }

  Future deleteBroadcastList(List<String> broadcastListId) async {
    //Database db = await DBProvider.provider.database;
    return this.db.delete(DatabaseMetadata.tableMember,
        where: '''${DatabaseMetadata.columnBroadcastListId} = ?''',
        whereArgs: broadcastListId);
  }
}
