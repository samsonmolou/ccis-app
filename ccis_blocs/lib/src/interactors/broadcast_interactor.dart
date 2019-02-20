import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';

class BroadcastInteractor {
  final ReactiveBroadcastRepository repository;

  BroadcastInteractor(this.repository);

  Stream<List<Broadcast>> get broadcasts {
    return repository
        .broadcasts()
        .map((entities) => entities.map(Broadcast.fromEntity).toList());
  }

  Stream<Broadcast> broadcast(String id) {
    return broadcasts.map((broadcasts) {
      return broadcasts.firstWhere(
        (broadcastList) => broadcastList.id == id,
        orElse: () => null,
      );
    }).where((broadcast) => broadcast != null);
  }

  Future<void> updateBroadcast(Broadcast broadcast) =>
      repository.updateBroadcast(broadcast.toEntity());

  Future<void> addNewBroadcast(Broadcast broadcast) {
    return repository.addNewBroadcast(broadcast.toEntity());
  }

  Future<void> deleteBroadcast(String id) => repository.deleteBroadcast([id]);
}
