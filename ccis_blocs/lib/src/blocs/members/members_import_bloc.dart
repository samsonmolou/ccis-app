import 'dart:async';

import 'package:ccis_blocs/src/interactors/members_interactor.dart';
import 'package:ccis_blocs/src/models/models.dart';

class MembersImportBloc {
  // Inputs
  final Sink<String> importMembers;

  // Outputs
  final Stream<List<Member>> importedMembers;

  final List<StreamSubscription<dynamic>> _subscriptions;


  factory MembersImportBloc(MembersInteractor interactor) {
    final importMembersController = StreamController<String>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user process importation
      importMembersController.stream.listen(interactor.importMembers),

    ];

    return MembersImportBloc._(
      importMembersController,
      interactor.importedMembers(),
      subscriptions,
    );
  }

  MembersImportBloc._(
      this.importMembers,
      this.importedMembers,
      this._subscriptions
      );

  void close() {
    importMembers.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}