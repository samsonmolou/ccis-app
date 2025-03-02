import 'dart:async';

import 'package:ccis_repository/src/entity/member_entity.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Members to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class MemberWebClient {
  final Duration delay;

  const MemberWebClient([this.delay = const Duration(milliseconds: 3000)]);

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
            '+22549631223',
            'ccis',
            'info'
          ),
          MemberEntity(
              '2',
              'Livai',
              'Ackerman',
              'M',
              '65',
              '+22549631223',
              'ccis',
              'info'
          ),
        ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postMembers(List<MemberEntity> members) async {
    return Future.value(true);
  }
}
