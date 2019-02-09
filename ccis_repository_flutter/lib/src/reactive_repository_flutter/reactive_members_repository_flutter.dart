import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class ReactiveMembersRepositoryFlutter implements ReactiveMembersRepository {
  final MembersRepository _repository;
  final BehaviorSubject<List<MemberEntity>> _subject;
  bool _loaded = false;

  ReactiveMembersRepositoryFlutter({
    @required MembersRepository repository,
    List<MemberEntity> seedValue,
  })  : this._repository = repository,
        this._subject = BehaviorSubject<List<MemberEntity>>(seedValue: seedValue);

  @override
  Future<void> addNewMember(MemberEntity member) async {
    _subject.add(List.unmodifiable([]
      ..addAll(_subject.value ?? [])
      ..add(member)));

    await _repository.newMember(member);
  }

  @override
  Future<void> deleteMember(List<String> idList) async {
    _subject.add(
      List<MemberEntity>.unmodifiable(_subject.value.fold<List<MemberEntity>>(
    <MemberEntity>[],
          (prev, entity) {
        return idList.contains(entity.id) ? prev : (prev..add(entity));
      },
    )),
    );

    await _repository.deleteMember(idList);
  }

  @override
  Stream<List<MemberEntity>> members() {
    if (!_loaded) _getAllMembers();

    return _subject.stream;
  }

  void _getAllMembers() {
    _loaded = true;

    _repository.getAllMembers().then((entities) {
      _subject.add(List<MemberEntity>.unmodifiable(
      []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }

  @override
  Future<void> updateMember(MemberEntity update) async {
    _subject.add(
      List<MemberEntity>.unmodifiable(_subject.value.fold<List<MemberEntity>>(
    <MemberEntity>[],
          (prev, entity) => prev..add(entity.id == update.id ? update : entity),
    )),
    );

    await _repository.updateMember(update);
  }
}
