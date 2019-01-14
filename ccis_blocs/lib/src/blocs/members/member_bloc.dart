import 'dart:async';

import 'package:ccis_blocs/src/models/models.dart';
import 'package:ccis_blocs/src/interactors/members_interactor.dart';

class MemberBloc {
  // Inputs
  final Sink<String> deleteMember;
  final Sink<Member> updateMember;

  final MembersInteractor _interactor;
  final List<StreamSubscription<dynamic>> _subscriptions;

  MemberBloc._(
      this.deleteMember,
      this.updateMember,
      this._interactor,
      this._subscriptions
      );

  factory MemberBloc(MembersInteractor interactor) {
    final removeMemberController = StreamController<String>(sync: true);
    final updateMemberController = StreamController<Member>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user updates an item, update the repository
      updateMemberController.stream.listen(interactor.updateMember),

      // When a user removes an item, remove it from the repository
      removeMemberController.stream.listen(interactor.deleteMember),
    ];

    return MemberBloc._(
      removeMemberController,
      updateMemberController,
      interactor,
      subscriptions,
    );
  }

  Stream<Member> member(String id) {
    return _interactor.member(id);
  }

  void close() {
    deleteMember.close();
    updateMember.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}