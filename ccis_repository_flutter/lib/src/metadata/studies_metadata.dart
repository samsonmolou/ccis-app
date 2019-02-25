import 'dart:async';
import 'dart:convert';

import 'package:ccis_repository/ccis_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class StudiesMetadata {

  const StudiesMetadata();

  Future<List<StudyEntity>> getAllStudies() async {
    final string = await loadStudiesMetadata();
    final json = JsonDecoder().convert(string);

    final studies = (json['studies'])
        .map<StudyEntity>((study) => StudyEntity.fromJson(study))
        .toList();

    return studies;
  }

  Future<String> loadStudiesMetadata() async {
    return await rootBundle.loadString('assets/studies.json');
  }
}