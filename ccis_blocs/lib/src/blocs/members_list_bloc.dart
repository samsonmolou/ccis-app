import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:ccis_blocs/src/models/models.dart';
import 'package:ccis_blocs/src/interactors/members_interactor.dart';


class MembersListBloc {
  // Inputs


  // Outputs
  final Stream<List<Member>> members;


  // Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory MembersListBloc(MembersInteractor interactor) {
    final subscriptions = <StreamSubscription<dynamic>>[

    ];

    return MembersListBloc._(
      interactor.members,
      subscriptions,
    );
  }

  MembersListBloc._(
      this.members,
      this._subscriptions);

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    _subscriptions.forEach((subscriptions) => subscriptions.cancel());
  }

}