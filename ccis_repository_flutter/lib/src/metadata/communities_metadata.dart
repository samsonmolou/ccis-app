import 'dart:async';
import 'dart:convert';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:flutter/services.dart' show rootBundle;


class CommunitiesMetadata {

  const CommunitiesMetadata();

  Future<List<CommunityEntity>> getAllCommunities() async {
    final string = await loadCommunitiesMetadata();
    final json = JsonDecoder().convert(string);

    final communities = (json['communities'])
        .map<CommunityEntity>((community) => CommunityEntity.fromJson(community))
        .toList();

    return communities;
  }

  Future<String> loadCommunitiesMetadata() async {
    return await rootBundle.loadString('assets/communities.json');
  }
}