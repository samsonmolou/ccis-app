import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/src/entity/broadcast_entity.dart';

/// A class that Loads broadcast from database file. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as study_repository_flutter or study_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class BroadcastRepository {
  /// Loads broadcast list from database
  Future<List<BroadcastEntity>> getAllBroadcasts();

  /// Persists broadcast list to sqflite corresponding table
  Future newBroadcast(BroadcastEntity broadcast);

  /// Update broadcast list to sqflite corresponding table
  Future updateBroadcast(BroadcastEntity broadcast);

  /// Delete broadcast list to sqflite corresponding table
  Future deleteBroadcast(List<String> broadcastId);
}
