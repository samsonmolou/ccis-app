import 'dart:async';

import 'package:ccis_repository/ccis_repository.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Members to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class MessageMock {
  final Duration delay;

  const MessageMock([this.delay = const Duration(milliseconds: 0)]);

  /// Mock that "fetches" some Members from a "web service" after a short delay
  Future<List<MessageEntity>> fetchMessages() async {
    return Future.delayed(
        delay,
            () => [ /*
          MessageEntity(
              '1',
              '1',
              '1',
              1,
              0,
              0,
              'Hello HEH',
              DateTime.now().toString(),
              DateTime.now().toString()
          ),
          MessageEntity(
              '2',
              '2',
              '2',
              1,
              0,
              0,
              'Hello HEH',
              DateTime.now().toString(),
              DateTime.now().toString()
          ),
        */]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postMembers(List<MemberEntity> members) async {
    return Future.value(true);
  }
}
