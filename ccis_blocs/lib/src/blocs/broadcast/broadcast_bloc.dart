import 'dart:async';

import 'package:ccis_blocs/src/interactors/broadcast_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';

class BroadcastBloc {
  // Inputs
  final Sink<String> deleteBroadcast;
  final Sink<Broadcast> updateBroadcast;
  final Sink<Broadcast> addBroadcast;

  final BroadcastInteractor _interactor;
  final List<StreamSubscription<dynamic>> _subscriptions;

  BroadcastBloc._(
      this.deleteBroadcast,
      this.updateBroadcast,
      this.addBroadcast,
      this._interactor,
      this._subscriptions
      );

  factory BroadcastBloc(BroadcastInteractor interactor) {
    final removeBroadcastController = StreamController<String>(sync: true);
    final updateBroadcastController = StreamController<Broadcast>(sync: true);
    final addBroadcastController = StreamController<Broadcast>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user updates an item, update the repository
      updateBroadcastController.stream.listen(interactor.updateBroadcast),

      addBroadcastController.stream.listen(interactor.addNewBroadcast),

      // When a user removes an item, remove it from the repository
      removeBroadcastController.stream.listen(interactor.deleteBroadcast),
    ];

    return BroadcastBloc._(
      removeBroadcastController,
      updateBroadcastController,
      addBroadcastController,
      interactor,
      subscriptions,
    );
  }

  Stream<Broadcast> broadcast(String id) {
    return _interactor.broadcast(id);
  }

  void close() {
    deleteBroadcast.close();
    updateBroadcast.close();
    addBroadcast.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}