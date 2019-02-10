import 'dart:io';

import 'package:ccis_repository_flutter/src/metadata/database_metadata.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider provider = DBProvider._();
  static Database _database;
  final _databaseName = "ccis_db";

  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      //TODO: use sqflite batch operation
      await db.execute('''
CREATE TABLE ${DatabaseMetadata.tableMember} (
  ${DatabaseMetadata.columnMemberId} TEXT PRIMARY KEY,
  ${DatabaseMetadata.columnMemberFirstName} TEXT,
  ${DatabaseMetadata.columnMemberSecondName} TEXT,
  ${DatabaseMetadata.columnMemberResidence} TEXT,
  ${DatabaseMetadata.columnMemberBedroomNumber} TEXT,
  ${DatabaseMetadata.columnMemberPhoneNumber} TEXT,
  ${DatabaseMetadata.columnMemberCommunity} TEXT,
  ${DatabaseMetadata.columnMemberStudy} TEXT
)
''');
      await db.execute('''
CREATE TABLE ${DatabaseMetadata.tableBroadcastList} (
  ${DatabaseMetadata.columnBroadcastListId} TEXT PRIMARY KEY,
  ${DatabaseMetadata.columnBroadcastListName} TEXT,
  ${DatabaseMetadata.columnBroadcastMembersId} TEXT
)
      ''');
    });
  }
}