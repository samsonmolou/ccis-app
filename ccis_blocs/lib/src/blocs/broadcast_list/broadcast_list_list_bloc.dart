import 'dart:async';

import 'package:ccis_blocs/src/interactors/broadcast_list_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';
import 'package:rxdart/rxdart.dart';


class BroadcastListListBloc {
  // Data

  // Inputs
  final Sink<BroadcastList> addBroadcastList;
  final Sink<String> deleteBroadcastList;
  final Sink<BroadcastList> updateBroadcastList;
  final Sink<String> searchBroadcastList;

  // Outputs
  final Stream<List<BroadcastList>> broadcastLists;
  final Stream<List<BroadcastList>> searchBroadcastListResult;

  // Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory BroadcastListListBloc(BroadcastListInteractor interactor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.
    final addBroadcastListController = StreamController<BroadcastList>(sync: true);
    final deleteBroadcastListController = StreamController<String>(sync: true);
    final updateMemberController = StreamController<BroadcastList>(sync: true);
    final searchMemberController = BehaviorSubject<String>(sync: true);

    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user adds an item, add it to the repository
      addBroadcastListController.stream.listen(interactor.addNewBroadcastList),
      deleteBroadcastListController.stream.listen(interactor.deleteBroadcastList),
      updateMemberController.stream.listen(interactor.updateBroadcastList),
    ];

    // To calculate the result of search, we combine the members with the current
    // search key and return the result of the search.
    //
    // Every time the members or the search query changes the visible items will emit
    // once again. We also convert the normal Stream into a BehaviorSubject
    // so the Stream can be listened to multiple times
    final searchBroadcastResultController = BehaviorSubject<List<BroadcastList>>();

    Observable
        .combineLatest2<List<BroadcastList>, String, List<BroadcastList>>(
      interactor.broadcastLists,
      searchMemberController.stream,
      _searchBroadcastList,
    )
        .pipe(searchBroadcastResultController);

    return BroadcastListListBloc._(
      addBroadcastListController,
      deleteBroadcastListController,
      updateMemberController,
      searchMemberController,
      searchBroadcastResultController,
      interactor.broadcastLists,
      subscriptions,
    );
  }

  BroadcastListListBloc._(
      this.addBroadcastList,
      this.deleteBroadcastList,
      this.updateBroadcastList,
      this.searchBroadcastList,
      this.searchBroadcastListResult,
      this.broadcastLists,
      this._subscriptions);

  static List<BroadcastList> _searchBroadcastList(List<BroadcastList> broadcastLists, String query) {
    final Iterable<BroadcastList> suggestions = broadcastLists.where(
            (broadcastList) => broadcastList.name.contains(query)
    );

    return suggestions.toList();
  }

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    addBroadcastList.close();
    deleteBroadcastList.close();
    updateBroadcastList.close();
    searchBroadcastList.close();
    _subscriptions.forEach((subscriptions) => subscriptions.cancel());
  }

}