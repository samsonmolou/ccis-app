import 'dart:async';

import 'package:ccis_repository/src/entity/broadcast_list_member_entity.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Members to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class BroadcastListMemberMock {
  final Duration delay;

  const BroadcastListMemberMock([this.delay = const Duration(milliseconds: 0)]);

  /// Mock that "fetches" some broadcasts from a "web service" after a short delay
  Future<List<BroadcastListMemberEntity>> fetchBroadcastListMembers() async {
    return Future.delayed(
        delay,
            () => [
          BroadcastListMemberEntity(
              '1',
              '1',
              '1'
          ),
          BroadcastListMemberEntity(
            '2',
            '2',
            '2'
          ),
        ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postBroadcastLists(List<BroadcastListMemberEntity> broadcastListMembers) async {
    return Future.value(true);
  }
}
