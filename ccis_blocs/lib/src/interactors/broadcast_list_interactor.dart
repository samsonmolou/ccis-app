import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';

class BroadcastListInteractor {
  final ReactiveBroadcastListRepository repository;

  BroadcastListInteractor(this.repository);

  Stream<List<BroadcastList>> get broadcastLists {
    return repository
        .broadcastLists()
        .map((entities) => entities.map(BroadcastList.fromEntity).toList());
  }

  Stream<BroadcastList> broadcastList(String id) {
    return broadcastLists.map((broadcastLists) {
      return broadcastLists.firstWhere(
            (broadcastList) => broadcastList.id == id,
        orElse: () => null,
      );
    }).where((broadcastList) => broadcastList != null);
  }


  Future<void> updateBroadcastList(BroadcastList broadcastList) => repository.updateBroadcastList(broadcastList.toEntity());

  Future<void> addNewBroadcastList(BroadcastList broadcastList) => repository.addNewBroadcastList(broadcastList.toEntity());

  Future<void> deleteBroadcastList(String id) => repository.deleteBroadcastList([id]);
}