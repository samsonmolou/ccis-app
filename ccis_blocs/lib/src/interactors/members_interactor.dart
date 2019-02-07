import 'dart:async';
import 'package:csv/csv.dart';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class MembersInteractor {
  final ReactiveMembersRepository repository;
  List<List<Member>> _importedMembers;
  String _filePath;

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

  Future<void> importMembers(String filePath) async {
    _filePath = filePath;
    /*
    try {
      final importedMembers = await rootBundle.loadString(filePath);
      _importedMembers = CsvToListConverter().convert(importedMembers);
    } catch (e) {
      print(e.toString());
    }
    */
  }

  Stream<List<Member>> importedMembers() {
    return members;
  }
}