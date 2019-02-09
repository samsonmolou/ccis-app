import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Studies.
class ReactiveStudiesRepositoryFlutter implements ReactiveStudiesRepository {
  final StudiesRepository _repository;
  final BehaviorSubject<List<StudyEntity>> _subject;
  bool _loaded = false;

  ReactiveStudiesRepositoryFlutter({
    @required StudiesRepository repository,
    List<StudyEntity> seedValue,
  })  : this._repository = repository,
        this._subject = BehaviorSubject<List<StudyEntity>>(seedValue: seedValue);

  @override
  Stream<List<StudyEntity>> studies() {
    if (!_loaded) _getAllStudies();

    return _subject.stream;
  }

  void _getAllStudies() {
    _loaded = true;

    _repository.getAllStudies().then((entities) {
      _subject.add(List<StudyEntity>.unmodifiable(
      []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }
}
