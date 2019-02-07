import 'dart:async';

import 'package:ccis_blocs/src/interactors/communities_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';

class CommunitiesListBloc {
  // Data

  // Inputs

  // Outputs
  final Stream<List<Community>> communities;

  // Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory CommunitiesListBloc(CommunitiesInteractor interactor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.


    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user adds an item, add it to the repository

    ];



    return CommunitiesListBloc._(
      interactor.communities,
      subscriptions,
    );
  }

  CommunitiesListBloc._(
      this.communities,
      this._subscriptions);


  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    _subscriptions.forEach((subscriptions) => subscriptions.cancel());
  }

}