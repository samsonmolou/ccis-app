import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';

class RankInteractor {
  final ReactiveRankRepository repository;

  RankInteractor(this.repository);

  Stream<Rank> get rank {
    return repository
        .getRank()
        .map(Rank.fromEntity);
  }

  Future<void> updateRank(Rank rank) {
    rank = rank.copyWith(value: rank.value + 1);
    return repository.updateRank(rank.toEntity());
  }
}