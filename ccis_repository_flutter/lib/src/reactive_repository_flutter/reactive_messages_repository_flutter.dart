import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class ReactiveMessagesRepositoryFlutter implements ReactiveMessagesRepository {
  final MessagesRepository _repository;
  final BehaviorSubject<List<MessageEntity>> _subject;
  bool _loaded = false;

  ReactiveMessagesRepositoryFlutter({
    @required MessagesRepository repository,
    List<MessageEntity> seedValue,
  })  : this._repository = repository,
        this._subject =
            BehaviorSubject<List<MessageEntity>>(seedValue: seedValue);

  @override
  Future<void> addNewMessage(MessageEntity message) async {
    _subject.add(List.unmodifiable([]
      ..addAll(_subject.value ?? [])
      ..add(message)));

    await _repository.newMessage(message);
  }

  @override
  Future<void> addMessages(List<MessageEntity> messages) async {
    _subject.add(List<MessageEntity>.unmodifiable([]
      ..addAll(_subject.value ?? [])
      ..addAll(messages)));

    await _repository.addMessages(messages);
  }

  @override
  Future<void> deleteMessage(List<String> idList) async {
    _subject.add(
      List<MessageEntity>.unmodifiable(_subject.value.fold<List<MessageEntity>>(
        <MessageEntity>[],
        (prev, entity) {
          return idList.contains(entity.id) ? prev : (prev..add(entity));
        },
      )),
    );

    await _repository.deleteMessage(idList);
  }

  @override
  Stream<List<MessageEntity>> messages() {
    if (!_loaded) _getAllMessages();

    return _subject.stream;
  }

  void _getAllMessages() {
    _loaded = true;

    _repository.getAllMessages().then((entities) {
      _subject.add(List<MessageEntity>.unmodifiable(
        []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }

  @override
  Future<void> updateMessage(MessageEntity update) async {
    _subject.add(
      List<MessageEntity>.unmodifiable(_subject.value.fold<List<MessageEntity>>(
        <MessageEntity>[],
        (prev, entity) => prev..add(entity.id == update.id ? update : entity),
      )),
    );

    await _repository.updateMessage(update);
  }
}
