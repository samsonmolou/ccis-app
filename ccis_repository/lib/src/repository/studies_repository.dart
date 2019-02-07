import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/src/entity/study_entity.dart';

/// A class that Loads study from json file. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as study_repository_flutter or study_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class StudiesRepository {
  /// Loads study first from json file.
  Future<List<StudyEntity>> getAllStudies();
}
