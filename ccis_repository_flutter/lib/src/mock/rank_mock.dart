import 'dart:async';
import 'package:ccis_repository/ccis_repository.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Members to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class RankMock {
  final Duration delay;

  const RankMock([this.delay = const Duration(milliseconds: 0)]);

  /// Mock that "fetches" some broadcasts from a "web service" after a short delay
  Future<RankEntity> fetchRank() async {
    //TODO: Put this to 0 on release
    return Future.delayed(
      delay,
      () => RankEntity(4),
    );
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postRank(List<RankEntity> rank) async {
    return Future.value(true);
  }
}
