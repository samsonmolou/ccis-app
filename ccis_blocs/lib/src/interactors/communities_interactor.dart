import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';

class CommunitiesInteractor {
  final ReactiveCommunitiesRepository repository;

  CommunitiesInteractor(this.repository);

  Stream<List<Community>> get communities {
    return repository
        .communities()
        .map((entities) => entities.map(Community.fromEntity).toList());
  }

  Stream<Community> community(String id) {
    return communities.map((community) {
      return community.firstWhere(
            (community) => community.id == id,
        orElse: () => null,
      );
    }).where((community) => community != null);
  }
}