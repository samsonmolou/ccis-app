import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/src/entity/rank_entity.dart';

/// A class that Loads community from xml file. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as community_repository_flutter or community_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class RankRepository {
  /// Loads members first from xml file. If they don't exist or encounter an
  /// error, it attempts to load the Members from a Web Client.
  Future<RankEntity> getRank();

  Future<void> updateRank(RankEntity rank);
}
