import 'dart:async';

import 'package:ccis_blocs/src/interactors/broadcast_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';
import 'package:rxdart/rxdart.dart';


class BroadcastsListBloc {
  // Data

  // Inputs
  final Sink<Broadcast> addBroadcast;
  final Sink<String> deleteBroadcast;
  final Sink<Broadcast> updateBroadcast;
  final Sink<String> searchBroadcast;

  // Outputs
  final Stream<List<Broadcast>> broadcasts;
  final Stream<List<Broadcast>> searchBroadcastResult;

  // Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory BroadcastsListBloc(BroadcastInteractor interactor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.
    final addBroadcastListController = StreamController<Broadcast>(sync: true);
    final deleteBroadcastListController = StreamController<String>(sync: true);
    final updateBroadcastController = StreamController<Broadcast>(sync: true);
    final searchBroadcastController = BehaviorSubject<String>(sync: true);

    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user adds an item, add it to the repository
      addBroadcastListController.stream.listen(interactor.addNewBroadcast),
      deleteBroadcastListController.stream.listen(interactor.deleteBroadcast),
      updateBroadcastController.stream.listen(interactor.updateBroadcast),
    ];

    // To calculate the result of search, we combine the members with the current
    // search key and return the result of the search.
    //
    // Every time the members or the search query changes the visible items will emit
    // once again. We also convert the normal Stream into a BehaviorSubject
    // so the Stream can be listened to multiple times
    final searchBroadcastResultController = BehaviorSubject<List<Broadcast>>();

    Observable
        .combineLatest2<List<Broadcast>, String, List<Broadcast>>(
      interactor.broadcasts,
      searchBroadcastController.stream,
      _searchBroadcastList,
    )
        .pipe(searchBroadcastResultController);

    return BroadcastsListBloc._(
      addBroadcastListController,
      deleteBroadcastListController,
      updateBroadcastController,
      searchBroadcastController,
      searchBroadcastResultController,
      interactor.broadcasts,
      subscriptions,
    );
  }

  BroadcastsListBloc._(
      this.addBroadcast,
      this.deleteBroadcast,
      this.updateBroadcast,
      this.searchBroadcast,
      this.searchBroadcastResult,
      this.broadcasts,
      this._subscriptions);

  static List<Broadcast> _searchBroadcastList(List<Broadcast> broadcasts, String query) {
    final Iterable<Broadcast> suggestions = broadcasts.where(
            (broadcast) => broadcast.message.contains(query)
    );

    return suggestions.toList();
  }

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    addBroadcast.close();
    deleteBroadcast.close();
    updateBroadcast.close();
    searchBroadcast.close();
    _subscriptions.forEach((subscriptions) => subscriptions.cancel());
  }

}