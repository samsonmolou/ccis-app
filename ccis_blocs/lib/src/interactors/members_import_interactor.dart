import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class MembersImportInteractor {
  final ReactiveMembersRepository repository;
  String _filePath;

  MembersImportInteractor(this.repository);

  Stream<List<Member>> get importedMembers {
    return repository
        .members()
        .map((entities) => entities.map(Member.fromEntity).toList());
  }

  Future<void> importMembers(String filePath) {

  }


}