import 'dart:async';

import 'package:ccis_blocs/src/interactors/broadcast_list_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';

class BroadcastListBloc {
  // Inputs
  final Sink<String> deleteBroadcastList;
  final Sink<BroadcastList> updateBroadcastList;

  final BroadcastListInteractor _interactor;
  final List<StreamSubscription<dynamic>> _subscriptions;

  BroadcastListBloc._(
      this.deleteBroadcastList,
      this.updateBroadcastList,
      this._interactor,
      this._subscriptions
      );

  factory BroadcastListBloc(BroadcastListInteractor interactor) {
    final removeMemberController = StreamController<String>(sync: true);
    final updateMemberController = StreamController<BroadcastList>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user updates an item, update the repository
      updateMemberController.stream.listen(interactor.updateBroadcastList),

      // When a user removes an item, remove it from the repository
      removeMemberController.stream.listen(interactor.deleteBroadcastList),
    ];

    return BroadcastListBloc._(
      removeMemberController,
      updateMemberController,
      interactor,
      subscriptions,
    );
  }

  Stream<BroadcastList> broadcastList(String id) {
    return _interactor.broadcastList(id);
  }

  void close() {
    deleteBroadcastList.close();
    updateBroadcastList.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}