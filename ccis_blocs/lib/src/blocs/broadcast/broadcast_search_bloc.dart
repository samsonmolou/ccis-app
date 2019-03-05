import 'dart:async';

import 'package:ccis_blocs/src/interactors/broadcast_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

class BroadcastSearchBloc {
  // Inputs
  Sink<String> searchBroadcast;

  // Outputs
  final Stream<List<Broadcast>> searchBroadcastResult;

  //Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory BroadcastSearchBloc(BroadcastInteractor interactor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.
    final searchBroadcastController = BehaviorSubject<String>(sync: true);

    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[];

    // To calculate the result of search, we combine the members with the current
    // search key and return the result of the search.
    //
    // Every time the members or the search query changes the visible items will emit
    // once again. We also convert the normal Stream into a BehaviorSubject
    // so the Stream can be listened to multiple times
    final searchBroadcastResultController = BehaviorSubject<List<Broadcast>>();

    Observable.combineLatest2<List<Broadcast>, String, List<Broadcast>>(
      interactor.broadcasts,
      searchBroadcastController.stream,
      _searchBroadcasts,
    ).pipe(searchBroadcastResultController);


    return BroadcastSearchBloc._(searchBroadcastController,
        searchBroadcastResultController, subscriptions);
  }

  BroadcastSearchBloc._(
      this.searchBroadcast, this.searchBroadcastResult, this._subscriptions);

  static List<Broadcast> _searchBroadcasts(
      List<Broadcast> broadcasts, String query) {
    //TODO: Use Search helpers instead
    final Iterable<Broadcast> suggestions = broadcasts.where(
        (broadcast) =>
            broadcast.message.toLowerCase().trim().contains(query.trim().toLowerCase()));

    return suggestions.toList();
  }

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    searchBroadcast.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}
