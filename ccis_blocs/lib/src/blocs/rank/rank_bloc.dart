import 'dart:async';

import 'package:ccis_blocs/src/interactors/rank_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';

class RankBloc {
  // Inputs
  final Sink<Rank> updateRank;

  //Output
  final Stream<Rank> getRank;

  final List<StreamSubscription<dynamic>> _subscriptions;

  RankBloc._(
      this.getRank,
      this.updateRank,
      this._subscriptions
      );

  factory RankBloc(RankInteractor interactor) {

    final updateRankController = StreamController<Rank>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user updates an item, update the repository
      updateRankController.stream.listen(interactor.updateRank),


    ];

    return RankBloc._(
      interactor.rank,
      updateRankController,
      subscriptions,
    );
  }

  void close() {
    updateRank.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}