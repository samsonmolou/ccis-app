import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';

class MessagesInteractor {
  final ReactiveMessagesRepository repository;

  MessagesInteractor(this.repository);

  Stream<List<Message>> get messages {
    return repository
        .messages()
        .map((entities) => entities.map(Message.fromEntity).toList());
  }

  Stream<Message> message(String id) {
    return messages.map((messages) {
      return messages.firstWhere(
            (message) => message.id == id,
        orElse: () => null,
      );
    }).where((message) => message != null);
  }


  Future<void> updateMessage(Message message) => repository.updateMessage(message.toEntity());

  Future<void> addNewMessage(Message message) => repository.addNewMessage(message.toEntity());

  Future<void> deleteMessage(String id) => repository.deleteMessage([id]);

  Future<void> addMessages(List<Message> messages) => repository.addMessages(messages.map((message) => message.toEntity()).toList());

}