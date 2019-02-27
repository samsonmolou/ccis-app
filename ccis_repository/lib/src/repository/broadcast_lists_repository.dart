import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/src/entity/broadcast_list_entity.dart';

/// A class that Loads broadcast from database file. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as study_repository_flutter or study_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class BroadcastListsRepository {
  /// Loads broadcast list from database
  Future<List<BroadcastListEntity>> getAllBroadcastLists();

  /// Persists broadcast list to sqflite corresponding table
  Future newBroadcastList(BroadcastListEntity broadcastList);

  /// Update broadcast list to sqflite corresponding table
  Future updateBroadcastList(BroadcastListEntity broadcastList);

  /// Delete broadcast list to sqflite corresponding table
  Future deleteBroadcastList(List<String> broadcastListId);
}
