import 'dart:async';
import 'dart:core';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:meta/meta.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Members and Persist members.
class CommunitiesRepositoryFlutter implements CommunitiesRepository {
  final CommunitiesMetadata communitiesMetadata;

  const CommunitiesRepositoryFlutter({
    @required this.communitiesMetadata,
  });

  /// Loads members first from  xml File.
  @override
  Future<List<CommunityEntity>> getAllCommunities() async {
    return await communitiesMetadata.getAllCommunities();
  }
}

