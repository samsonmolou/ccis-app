import 'dart:async';

import 'package:ccis_repository/src/entity/rank_entity.dart';
import 'package:ccis_repository_flutter/src/metadata/rank_metadata.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class RankSqlite {

  const RankSqlite();

  Future<RankEntity> getRank() async {
    //TODO: Implement Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(RankMetadata.tableName);

    final rank = res.isNotEmpty
      ? res.map((r) => RankEntity.fromJson(r)).toList()
        : [];

    return rank.first;
  }


  Future updateRank(RankEntity rank) async {
    //TODO: Implement Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.update(RankMetadata.tableName, rank.toJson());

    return res;
  }

  Future newRank(RankEntity newRank) async {
    //TODO: Implement Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.insert(RankMetadata.tableName, newRank.toJson());

    return res;
  }
}
