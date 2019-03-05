import 'dart:async';

import 'package:ccis_blocs/src/helpers/search.dart';
import 'package:ccis_blocs/src/interactors/broadcast_list_interactor.dart';
import 'package:ccis_blocs/src/interactors/members_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

class BroadcastListAddEditSearchBloc {
  // Inputs
  Sink<String> query;

  // Outputs
  final Stream<List<Member>> queryResult;

  //Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory BroadcastListAddEditSearchBloc(MembersInteractor interactor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.
    final queryController = BehaviorSubject<String>(sync: true);

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
    final queryResultController = BehaviorSubject<List<Member>>();

    Observable.combineLatest2<List<Member>, String, List<Member>>(
      interactor.members,
      queryController.stream,
      _searchMembers,
    ).pipe(queryResultController);



    return BroadcastListAddEditSearchBloc._(
        queryController, queryResultController, subscriptions);
  }

  BroadcastListAddEditSearchBloc._(
      this.query, this.queryResult, this._subscriptions);

  static List<Member> _searchMembers(List<Member> members, String query) {
    final Iterable<Member> results = query.isEmpty
        ? members
        : Search.searchMember(members, query);

    return results.toList();
  }

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    query.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}
