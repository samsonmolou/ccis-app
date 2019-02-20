import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class ReactiveRankRepositoryFlutter implements ReactiveRankRepository {
  final RankRepository _repository;
  final BehaviorSubject<RankEntity> _subject;
  bool _loaded = false;

  ReactiveRankRepositoryFlutter({
    @required RankRepository repository,
    RankEntity seedValue,
  })  : this._repository = repository,
        this._subject = BehaviorSubject<RankEntity>(seedValue: seedValue);

  @override
  Stream<RankEntity> getRank() {
    _getRank();

    return _subject.stream;
  }

  void _getRank() {
    _repository.getRank().then((entity) {
      _subject.add(entity);
    });
  }

  @override
  Future<void> updateRank(RankEntity update) async {

    _subject.add(update);

    await _repository.updateRank(update);
  }
}
