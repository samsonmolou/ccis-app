import 'dart:async';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/src/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class MessageSqlite {

  const MessageSqlite();

  Future<List<MessageEntity>> getAllMessages() async {
    //TODO: use Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.query(MessagesMetadata.tableName);
    final messages = res.isNotEmpty
        ? res.map((message) => MessageEntity.fromJson(message)).toList()
        : [];

    return messages;
  }

  Future newMessage(MessageEntity newMessage) async {
    //TODO: use Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.insert(MessagesMetadata.tableName, newMessage.toJson());

    return res;
  }

  Future updateMessage(MessageEntity message) async {
    //TODO: use Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    var res = await db.update(MessagesMetadata.tableName, message.toJson(),
        where: '''${MessagesMetadata.id} = ?''',
        whereArgs: [message.id]);

    return res;
  }

  Future deleteMessage(List<String> messagesId) async {
    //TODO: use Demeter Law for less coupling
    Database db = await DBProvider.provider.database;
    return await db.delete(MessagesMetadata.tableName,
        where: '''${MessagesMetadata.id} = ?''',
        whereArgs: messagesId);
  }
}
