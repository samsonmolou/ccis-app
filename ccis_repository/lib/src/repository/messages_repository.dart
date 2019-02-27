import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/src/entity/message_entity.dart';

/// A class that Loads and Persists members. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as members_repository_flutter or members_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class MessagesRepository {
  /// Loads members first from Sqflite. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  Future<List<MessageEntity>> getAllMessages();


  /// Persists member to sqflite member table
  Future newMessage(MessageEntity message);

  /// Update member into sqlflite member table
  Future updateMessage(MessageEntity message);

  /// Delete member into sqflite member table
  Future deleteMessage(List<String> messageId);

  /// Add batch messages
  Future addMessages(List<MessageEntity> messages);
}
