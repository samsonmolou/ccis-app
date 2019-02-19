import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class ReactiveBroadcastListsRepositoryFlutter implements ReactiveBroadcastListRepository {
  final BroadcastListRepository _repository;
  final BehaviorSubject<List<BroadcastListEntity>> _subject;
  bool _loaded = false;

  ReactiveBroadcastListsRepositoryFlutter({
    @required BroadcastListRepository repository,
    List<BroadcastListEntity> seedValue,
  })  : this._repository = repository,
        this._subject = BehaviorSubject<List<BroadcastListEntity>>(seedValue: seedValue);

  @override
  Stream<List<BroadcastListEntity>> broadcastLists() {
    if (!_loaded) _getAllBroadcastLists();

    return _subject.stream;
  }

  void _getAllBroadcastLists() {
    _loaded = true;

    _repository.getAllBroadcastLists().then((entities) {
      _subject.add(List<BroadcastListEntity>.unmodifiable(
      []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }

  @override
  Future<void> addNewBroadcastList(BroadcastListEntity broadcastList) async {
    _subject.add(List.unmodifiable([]
      ..addAll(_subject.value ?? [])
      ..add(broadcastList)));

    await _repository.newBroadcastList(broadcastList);
  }

  @override
  Future<void> deleteBroadcastList(List<String> idList) async {
    _subject.add(
      List<BroadcastListEntity>.unmodifiable(_subject.value.fold<List<BroadcastListEntity>>(
    <BroadcastListEntity>[],
          (prev, entity) {
        return idList.contains(entity.id) ? prev : (prev..add(entity));
      },
    )),
    );

    await _repository.deleteBroadcastList(idList);
  }

  @override
  Future<void> updateBroadcastList(BroadcastListEntity update) async {
    _subject.add(
      List<BroadcastListEntity>.unmodifiable(_subject.value.fold<List<BroadcastListEntity>>(
    <BroadcastListEntity>[],
          (prev, entity) => prev..add(entity.id == update.id ? update : entity),
    )),
    );

    await _repository.updateBroadcastList(update);
  }
}
