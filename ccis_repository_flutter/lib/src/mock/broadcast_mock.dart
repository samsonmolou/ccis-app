import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:ccis_repository/src/entity/broadcast_entity.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Members to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class BroadcastMock {
  final Duration delay;

  const BroadcastMock([this.delay = const Duration(milliseconds: 0)]);

  /// Mock that "fetches" some broadcasts from a "web service" after a short delay
  Future<List<BroadcastEntity>> fetchBroadcasts() async {
    return Future.delayed(
        delay,
        () => [
              BroadcastEntity(
                  '1',
                  1,
                  '1',
                  'Hello @nom, @prenom, @telephone, @communaute, @filiere, @residence, @chambre',
                  DateTime.now().toString(),
                  'Diffusion'),
              BroadcastEntity(
                  '2',
                  2,
                  '2',
                  'Hello @nom, @prenom, @telephone, @communaute, @filiere, @residence, @chambre',
                  DateTime.now().toString(),
                  'Diffusion'),
              BroadcastEntity(
                  '3',
                  3,
                  '3',
                  'Hello @nom, @prenom, @telephone, @communaute, @filiere, @residence, @chambre',
                  DateTime.now().toString(),
                  'Diffusion'),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postBroadcasts(List<BroadcastEntity> broadcasts) async {
    return Future.value(true);
  }
}
