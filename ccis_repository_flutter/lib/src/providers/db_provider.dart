import 'dart:io';

import 'package:ccis_repository_flutter/src/metadata/metadata.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider provider = DBProvider._();
  static Database _database;
  final _databaseName = "ccis_db.db";

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      //TODO: use sqflite batch operation
      await db.execute('''
PRAGMA foreign_keys=ON;
''');
      // Create Member table
      await db.execute('''
CREATE TABLE ${MembersMetadata.tableName} (
  ${MembersMetadata.id} TEXT PRIMARY KEY,
  ${MembersMetadata.firstName} TEXT,
  ${MembersMetadata.secondName} TEXT,
  ${MembersMetadata.residence} TEXT,
  ${MembersMetadata.bedroomNumber} TEXT,
  ${MembersMetadata.phoneNumber} TEXT,
  ${MembersMetadata.community} TEXT,
  ${MembersMetadata.study} TEXT
)
''');
      // Create broadcast list table
      await db.execute('''
CREATE TABLE ${BroadcastListsMetadata.tableName} (
  ${BroadcastListsMetadata.id} TEXT PRIMARY KEY,
  ${BroadcastListsMetadata.name} TEXT,
  ${BroadcastListsMetadata.membersId} TEXT
)
      ''');

      await db.execute('''
CREATE TABLE ${BroadcastsMetadata.tableName} (
  ${BroadcastsMetadata.id} TEXT PRIMARY KEY,
  ${BroadcastsMetadata.rank} INTEGER,
  ${BroadcastsMetadata.broadcastListId} TEXT
  ${BroadcastsMetadata.message} TEXT,
  ${BroadcastsMetadata.dateHeure} TEXT
)
      ''');

      /*

      // Create relationship table between member and broadcast list tables
      await db.execute('''
CREATE TABLE ${BroadcastListMembersMetadata.tableName} (
  ${BroadcastListMembersMetadata.id} TEXT PRIMARY KEY,
  ${BroadcastListMembersMetadata.broadcastListId} TEXT,
  ${BroadcastListMembersMetadata.memberId} TEXT,
  FOREIGN KEY (${BroadcastListMembersMetadata.memberId}) REFERENCES
  ${MembersMetadata.tableName} (${MembersMetadata.id})
  ON DELETE CASCADE,
  FOREIGN KEY (${BroadcastListMembersMetadata.broadcastListId}) REFERENCES
  ${BroadcastListsMetadata.tableName} (${BroadcastListsMetadata.id})
  ON DELETE CASCADE
)
      '''); */
    });
  }
}
