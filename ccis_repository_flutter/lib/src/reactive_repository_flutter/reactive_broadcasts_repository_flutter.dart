import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class ReactiveBroadcastsRepositoryFlutter implements ReactiveBroadcastRepository {
  final BroadcastRepository _repository;
  final BehaviorSubject<List<BroadcastEntity>> _subject;
  bool _loaded = false;

  ReactiveBroadcastsRepositoryFlutter({
    @required BroadcastRepository repository,
    List<BroadcastEntity> seedValue,
  })  : this._repository = repository,
        this._subject = BehaviorSubject<List<BroadcastEntity>>(seedValue: seedValue);

  @override
  Stream<List<BroadcastEntity>> broadcasts() {
    if (!_loaded) _getAllBroadcasts();

    return _subject.stream;
  }

  void _getAllBroadcasts() {
    _loaded = true;

    _repository.getAllBroadcasts().then((entities) {
      _subject.add(List<BroadcastEntity>.unmodifiable(
      []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }

  @override
  Future<void> addNewBroadcast(BroadcastEntity broadcast) async {

    _subject.add(List.unmodifiable([]
      ..addAll(_subject.value ?? [])
      ..add(broadcast)));

    await _repository.newBroadcast(broadcast);
  }

  @override
  Future<void> deleteBroadcast(List<String> idList) async {
    _subject.add(
      List<BroadcastEntity>.unmodifiable(_subject.value.fold<List<BroadcastEntity>>(
    <BroadcastEntity>[],
          (prev, entity) {
        return idList.contains(entity.id) ? prev : (prev..add(entity));
      },
    )),
    );

    await _repository.deleteBroadcast(idList);
  }

  @override
  Future<void> updateBroadcast(BroadcastEntity update) async {
    _subject.add(
      List<BroadcastEntity>.unmodifiable(_subject.value.fold<List<BroadcastEntity>>(
    <BroadcastEntity>[],
          (prev, entity) => prev..add(entity.id == update.id ? update : entity),
    )),
    );

    await _repository.updateBroadcast(update);
  }
}
