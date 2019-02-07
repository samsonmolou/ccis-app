import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';

class StudiesInteractor {
  final ReactiveStudiesRepository repository;

  StudiesInteractor(this.repository);

  Stream<List<Study>> get studies {
    return repository
        .studies()
        .map((entities) => entities.map(Study.fromEntity).toList());
  }

  Stream<Study> study(String id) {
    return studies.map((study) {
      return study.firstWhere(
            (study) => study.id == id,
        orElse: () => null,
      );
    }).where((study) => study != null);
  }
}