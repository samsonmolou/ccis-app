import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';

class BroadcastListMemberInteractor {
  final ReactiveBroadcastListMemberRepository repository;

  BroadcastListMemberInteractor(this.repository);

  Stream<List<BroadcastListMember>> get broadcastListMembers {
    return repository
        .broadcastListMembers()
        .map((entities) => entities.map(BroadcastListMember.fromEntity).toList());
  }

  Stream<BroadcastListMember> broadcastListMember(String id) {
    return broadcastListMembers.map((broadcastListMembers) {
      return broadcastListMembers.firstWhere(
            (broadcastListMember) => broadcastListMember.id == id,
        orElse: () => null,
      );
    }).where((broadcastListMember) => broadcastListMember != null);
  }

  Stream<BroadcastListMember> broadcastListMembersByMemberId(String memberId) {
    //TODO: Think about performance later, call repository or this
    return broadcastListMembers.map((broadcastListMembers) {
      return broadcastListMembers.firstWhere(
            (broadcastListMember) => broadcastListMember.memberId == memberId,
        orElse: () => null,
      );
    }).where((broadcastListMember) => broadcastListMember != null);
  }

  Stream<BroadcastListMember> broadcastListMembersByBroadcastListId(String broadcastListId) {
    //TODO: Think about performance later, call repository or this
    return broadcastListMembers.map((broadcastListMembers) {
      return broadcastListMembers.firstWhere(
            (broadcastListMember) => broadcastListMember.broadcastListId == broadcastListId,
        orElse: () => null,
      );
    }).where((broadcastListMember) => broadcastListMember != null);
  }


  Future<void> updateBroadcastListMember(BroadcastListMember broadcastListMember) => repository.updateBroadcastListMember(broadcastListMember.toEntity());

  Future<void> addNewBroadcastListMember(BroadcastListMember broadcastListMember) => repository.addNewBroadcastListMember(broadcastListMember.toEntity());

  Future<void> deleteBroadcastListMember(String id) => repository.deleteBroadcastListMember([id]);
}