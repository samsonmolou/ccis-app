import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:meta/meta.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class StudiesRepositoryFlutter implements StudiesRepository {
  final StudiesMetadata studiesMetadata;

  const StudiesRepositoryFlutter({
    @required this.studiesMetadata,
  });

  /// Loads studies from  metadata File.
  @override
  Future<List<StudyEntity>> getAllStudies() async {
    return await studiesMetadata.getAllStudies();
  }
}

