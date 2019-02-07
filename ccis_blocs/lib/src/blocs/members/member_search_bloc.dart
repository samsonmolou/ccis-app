import 'dart:async';

import 'package:ccis_blocs/src/interactors/members_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

class MemberSearchBloc {
  // Inputs
  Sink<String> searchMember;

  // Outputs
  final Stream<List<Member>> searchMemberResult;

  //Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory MemberSearchBloc(MembersInteractor interactor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.
    final searchMemberController = BehaviorSubject<String>(sync: true);

    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[

    ];

    // To calculate the result of search, we combine the members with the current
    // search key and return the result of the search.
    //
    // Every time the members or the search query changes the visible items will emit
    // once again. We also convert the normal Stream into a BehaviorSubject
    // so the Stream can be listened to multiple times
    final searchMemberResultController = BehaviorSubject<List<Member>>();

    Observable.combineLatest2<List<Member>, String, List<Member>>(
      interactor.members,
      searchMemberController.stream,
      _searchMembers,
    )
      .pipe(searchMemberResultController);

    return MemberSearchBloc._(
      searchMemberController,
      searchMemberResultController,
      subscriptions
    );

  }

  MemberSearchBloc._(
      this.searchMember,
      this.searchMemberResult,
      this._subscriptions
      );

  static List<Member> _searchMembers(List<Member> members, String query) {

    return members.toList();
  }

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    searchMember.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}