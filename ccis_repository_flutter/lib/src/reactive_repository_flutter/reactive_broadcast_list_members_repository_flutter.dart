import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class ReactiveBroadcastListMemberRepositoryFlutter implements ReactiveBroadcastListMemberRepository {
  final BroadcastListMembersRepository _repository;
  final BehaviorSubject<List<BroadcastListMemberEntity>> _subject;
  bool _loadedBroadcastListMembers = false;
  bool _loadedBroadcastListMembersByBroadcastListId = false;
  bool _loadedBroadcastListMembersByMemberId = false;


  ReactiveBroadcastListMemberRepositoryFlutter({
    @required BroadcastListMembersRepository repository,
    List<BroadcastListMemberEntity> seedValue,
  })  : this._repository = repository,
        this._subject = BehaviorSubject<List<BroadcastListMemberEntity>>(seedValue: seedValue);

  @override
  Stream<List<BroadcastListMemberEntity>> broadcastListMembers() {
    if (!_loadedBroadcastListMembers) _getAllBroadcastListMembers();

    return _subject.stream;
  }

  @override
  Stream<List<BroadcastListMemberEntity>> broadcastListMembersByBroadcastListId(String broadcastListId) {
    if (!_loadedBroadcastListMembersByBroadcastListId) _getAllBroadcastListMembersByBroadcastListId(broadcastListId);

    return _subject.stream;
  }

  @override
  Stream<List<BroadcastListMemberEntity>> broadcastListMembersByMemberId(String memberId) {
    if (!_loadedBroadcastListMembersByMemberId) _getAllBroadcastListMembersByMemberId(memberId);

    return _subject.stream;
  }

  void _getAllBroadcastListMembers() {
    _loadedBroadcastListMembers = true;

    _repository.getAllBroadcastListMembers().then((entities) {
      _subject.add(List<BroadcastListMemberEntity>.unmodifiable(
      []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }

  void _getAllBroadcastListMembersByBroadcastListId(String broadcastListId) {
    _loadedBroadcastListMembersByBroadcastListId = true;

    _repository.getAllBroadcastListMembers().then((entities) {
      _subject.add(List<BroadcastListMemberEntity>.unmodifiable(
      []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }

  void _getAllBroadcastListMembersByMemberId(String memberId) {
    _loadedBroadcastListMembersByMemberId = true;

    _repository.getAllBroadcastListMembers().then((entities) {
      _subject.add(List<BroadcastListMemberEntity>.unmodifiable(
      []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }

  @override
  Future<void> addNewBroadcastListMember(BroadcastListMemberEntity broadcastListMember) async {
    _subject.add(List.unmodifiable([]
      ..addAll(_subject.value ?? [])
      ..add(broadcastListMember)));

    await _repository.newBroadcastListMember(broadcastListMember);
  }

  @override
  Future<void> deleteBroadcastListMember(List<String> idList) async {
    _subject.add(
      List<BroadcastListMemberEntity>.unmodifiable(_subject.value.fold<List<BroadcastListMemberEntity>>(
    <BroadcastListMemberEntity>[],
          (prev, entity) {
        return idList.contains(entity.id) ? prev : (prev..add(entity));
      },
    )),
    );

    await _repository.deleteBroadcastListMember(idList);
  }

  @override
  Future<void> updateBroadcastListMember(BroadcastListMemberEntity update) async {
    _subject.add(
      List<BroadcastListMemberEntity>.unmodifiable(_subject.value.fold<List<BroadcastListMemberEntity>>(
    <BroadcastListMemberEntity>[],
          (prev, entity) => prev..add(entity.id == update.id ? update : entity),
    )),
    );

    await _repository.updateBroadcastListMember(update);
  }
}
