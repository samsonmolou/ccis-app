import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:meta/meta.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class MessagesRepositoryFlutter implements MessagesRepository {
  final MessageMock messageMock;
  final MessageSqlite sqlite;

  const MessagesRepositoryFlutter({
    @required this.sqlite,
    this.messageMock = const MessageMock(),
  });

  /// Loads todos first from Sqflite. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  @override
  Future<List<MessageEntity>> getAllMessages() async {
    //return await sqlite.getAllMembers();

    try {
      return await sqlite.getAllMessages();
    } catch (e) {
      print(e);
      final messages = await messageMock.fetchMessages();

      messages.forEach((message) => sqlite.newMessage(message));

      return messages;
    }
  }


  /// Persists messages to sqflite message table
  @override
  Future newMessage(MessageEntity message) {
    // TODO: implement newMessage
    return Future.wait<dynamic>([
      sqlite.newMessage(message)
    ]);
  }

  /// Persists list of messages to sqflite message table
  @override
  Future addMessages(List<MessageEntity> messages) {
    // TODO: implement newMessage
    return Future.wait<dynamic>([
      sqlite.addMessages(messages)
    ]);
  }

  /// Update member into sqflite member table
  @override
  Future updateMessage(MessageEntity message) {
    // TODO: implement updateMessage
    return Future.wait<dynamic>([
      sqlite.updateMessage(message)
    ]);
  }

  /// Delete member info sqflite member table
  @override
  Future deleteMessage(List<String> messagesId) {
    // TODO: implement deleteMessage
    return Future.wait<dynamic>([
      sqlite.deleteMessage(messagesId)
    ]);
  }

}

