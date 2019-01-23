import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';

class MembersInteractor {
  final ReactiveMembersRepository repository;

  MembersInteractor(this.repository);

  Stream<List<Member>> get members {
    return repository
        .members()
        .map((entities) => entities.map(Member.fromEntity).toList());
  }

  Stream<Member> member(String id) {
    return members.map((members) {
      return members.firstWhere(
            (member) => member.id == id,
        orElse: () => null,
      );
    }).where((member) => member != null);
  }


  Future<void> updateMember(Member member) => repository.updateMember(member.toEntity());

  Future<void> addNewMember(Member member) => repository.addNewMember(member.toEntity());

  Future<void> deleteMember(String id) => repository.deleteMember([id]);
}