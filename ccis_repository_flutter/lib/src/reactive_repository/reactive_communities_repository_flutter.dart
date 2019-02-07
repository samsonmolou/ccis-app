import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class ReactiveCommunitiesRepositoryFlutter implements ReactiveCommunitiesRepository {
  final CommunitiesRepository _repository;
  final BehaviorSubject<List<CommunityEntity>> _subject;
  bool _loaded = false;

  ReactiveCommunitiesRepositoryFlutter({
    @required CommunitiesRepository repository,
    List<CommunityEntity> seedValue,
  })  : this._repository = repository,
        this._subject = BehaviorSubject<List<CommunityEntity>>(seedValue: seedValue);

  @override
  Stream<List<CommunityEntity>> communities() {
    if (!_loaded) _getAllCommunities();

    return _subject.stream;
  }

  void _getAllCommunities() {
    _loaded = true;

    _repository.getAllCommunities().then((entities) {
      _subject.add(List<CommunityEntity>.unmodifiable(
      []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }
}
