import 'dart:async';

import 'package:ccis_repository/ccis_repository.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Members to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class MemberMock {
  final Duration delay;

  const MemberMock([this.delay = const Duration(milliseconds: 0)]);

  /// Mock that "fetches" some Members from a "web service" after a short delay
  Future<List<MemberEntity>> fetchMembers() async {
    return Future.delayed(
        delay,
            () => [
          MemberEntity(
            '1',
            'Molou',
            'Samson',
            'M',
            '65',
            '44286265',
            CommunityEntity("2", "MICI"),
            StudyEntity("3", "TSBU")
          ),
          MemberEntity(
              '2',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ),
          MemberEntity(
              '3',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '4',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '5',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '6',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '7',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '8',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '9',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '10',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '11',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '12',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '13',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '14',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '15',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '16',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '17',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ), MemberEntity(
              '18',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '44286265',
              CommunityEntity("2", "MICI"),
              StudyEntity("3", "TSBU")
          ),

        ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postMembers(List<MemberEntity> members) async {
    return Future.value(true);
  }
}
