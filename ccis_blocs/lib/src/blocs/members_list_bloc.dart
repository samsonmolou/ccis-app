import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:ccis_blocs/src/models/models.dart';
import 'package:ccis_blocs/src/interactors/members_interactor.dart';


class MembersListBloc {
  // Inputs
  final Sink<Member> addMember;

  // Outputs
  final Stream<List<Member>> members;


  // Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory MembersListBloc(MembersInteractor interactor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.
    final addMemberController = StreamController<Member>(sync: true);

    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user adds an item, add it to the repository
      addMemberController.stream.listen(interactor.addNewMember),
    ];

    return MembersListBloc._(
      addMemberController,
      interactor.members,
      subscriptions,
    );
  }

  MembersListBloc._(
      this.addMember,
      this.members,
      this._subscriptions);

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    _subscriptions.forEach((subscriptions) => subscriptions.cancel());
  }

}