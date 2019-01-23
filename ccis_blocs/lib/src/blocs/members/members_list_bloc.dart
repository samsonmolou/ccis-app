import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:ccis_blocs/src/models/models.dart';
import 'package:ccis_blocs/src/interactors/members_interactor.dart';


class MembersListBloc {
  // Data

  // Inputs
  final Sink<Member> addMember;
  final Sink<String> deleteMember;
  final Sink<Member> updateMember;
  final Sink<String> searchMember;
  final Sink<String> importMembers;

  // Outputs
  final Stream<List<Member>> members;
  final Stream<List<Member>> searchMemberResult;

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
    final searchMemberController = BehaviorSubject<String>(sync: true);
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

    // To calculate the result of search, we combine the members with the current
    // search key and return the result of the search.
    //
    // Every time the members or the search query changes the visible items will emit
    // once again. We also convert the normal Stream into a BehaviorSubject
    // so the Stream can be listened to multiple times
    final searchMemberResultController = BehaviorSubject<List<Member>>();

    Observable
      .combineLatest2<List<Member>, String, List<Member>>(
      interactor.members,
      searchMemberController.stream,
      _searchMembers,
    )
      .pipe(searchMemberResultController);

    return MembersListBloc._(
      addMemberController,
      deleteMemberController,
      updateMemberController,
      searchMemberController,
      searchMemberResultController,
      interactor.members,
      subscriptions,
    );
  }

  MembersListBloc._(
      this.addMember,
      this.deleteMember,
      this.updateMember,
      this.searchMember,
      this.searchMemberResult,
      this.members,
      this._subscriptions);

  static List<Member> _searchMembers(List<Member> members, String query) {
    final Iterable<Member> suggestions = members.where(
        (member) => member.fullName.contains(query)
            || member.study.contains(query)
            || member.community.contains(query)
            || member.residenceBedroom.contains(query)
            || member.phoneNumber.contains(query)
    );

    return suggestions.toList();
  }

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    addMember.close();
    deleteMember.close();
    updateMember.close();
    searchMember.close();
    _subscriptions.forEach((subscriptions) => subscriptions.cancel());
  }

}