import 'dart:io';

import 'package:ccis_repository_flutter/src/keys/database_keys.dart';
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
      await db.execute('''
CREATE TABLE $tableMember (
  $columnMemberId TEXT PRIMARY KEY,
  $columnMemberFirstName TEXT,
  $columnMemberSecondName TEXT,
  $columnMemberResidence TEXT,
  $columnMemberBedroomNumber TEXT,
  $columnMemberPhoneNumber TEXT,
  $columnMemberCommunity TEXT,
  $columnMemberStudy TEXT
)
'''
      );
    });
  }
}