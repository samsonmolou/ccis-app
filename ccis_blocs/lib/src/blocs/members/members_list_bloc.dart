import 'dart:async';

import 'package:ccis_blocs/src/interactors/members_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';


class MembersListBloc {
  // Data

  // Inputs
  final Sink<Member> addMember;
  final Sink<String> deleteMember;
  final Sink<Member> updateMember;

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
    final deleteMemberController = StreamController<String>(sync: true);
    final updateMemberController = StreamController<Member>(sync: true);

    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user adds an item, add it to the repository
      addMemberController.stream.listen(interactor.addNewMember),
      deleteMemberController.stream.listen(interactor.deleteMember),
      updateMemberController.stream.listen(interactor.updateMember),
    ];


    return MembersListBloc._(
      addMemberController,
      deleteMemberController,
      updateMemberController,
      interactor.members,
      subscriptions,
    );
  }

  MembersListBloc._(
      this.addMember,
      this.deleteMember,
      this.updateMember,
      this.members,
      this._subscriptions);


  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    addMember.close();
    deleteMember.close();
    updateMember.close();
    _subscriptions.forEach((subscriptions) => subscriptions.cancel());
  }

}