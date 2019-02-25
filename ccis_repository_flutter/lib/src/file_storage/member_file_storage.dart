import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ccis_repository/ccis_repository.dart';

/// Loads and saves a List of Members using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class MemberFileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const MemberFileStorage(
      this.tag,
      this.getDirectory,
      );

  Future<List<MemberEntity>> loadMembers() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final members = (json['members'])
        .map<MemberEntity>((member) => MemberEntity.fromJson(member))
        .toList();

    return members;
  }

  Future<File> saveMembers(List<MemberEntity> members) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'members': members.map((member) => member.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/ArchSampleStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
