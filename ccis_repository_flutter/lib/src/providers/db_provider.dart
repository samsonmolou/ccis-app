import 'dart:io';

import 'package:ccis_repository/ccis_repository.dart';
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
  ${BroadcastsMetadata.broadcastListId} TEXT,
  ${BroadcastsMetadata.message} TEXT,
  ${BroadcastsMetadata.dateTime} TEXT,
  ${BroadcastsMetadata.name} TEXT
)
      ''');

      ///this table must contain a single row. I use it for broadcast rank
      await db.execute('''
CREATE TABLE ${RankMetadata.tableName} (
  ${RankMetadata.value} INTEGER
)
      ''');

      // Create Message table
      await db.execute('''
CREATE TABLE ${MessagesMetadata.tableName} (
  ${MessagesMetadata.id} TEXT PRIMARY KEY,
  ${MessagesMetadata.broadcastId} TEXT,
  ${MessagesMetadata.memberId} TEXT,
  ${MessagesMetadata.isWaiting} INTEGER,
  ${MessagesMetadata.isSent} INTEGER,
  ${MessagesMetadata.isReceived} INTEGER,
  ${MessagesMetadata.content} TEXT,
  ${MessagesMetadata.sentAt} TEXT,
  ${MessagesMetadata.receivedAt} TEXT
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
