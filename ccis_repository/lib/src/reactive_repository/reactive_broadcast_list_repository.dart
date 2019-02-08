import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/src/entity/broadcast_list_entity.dart';

/// A data layer class works with reactive data sources, such as Firebase. This
/// class emits a Stream of MembersEntities. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as firebase_repository_flutter.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class ReactiveBroadcastListRepository {
  Stream<List<BroadcastListEntity>> broadcastLists();

  Future<void> addNewBroadcastList(BroadcastListEntity broadcastList);

  Future<void> deleteBroadcastList(List<String> idList);

  Future<void> updateBroadcastList(BroadcastListEntity broadcastList);
}
