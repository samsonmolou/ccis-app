import 'dart:async';

import 'package:ccis_blocs/src/models/models.dart';
import 'package:ccis_blocs/src/interactors/members_import_interactor.dart';

class MembersImportBloc {
  // Inputs

  final Sink<String> importMembers;

  // Outputs
  final Stream<List<Member>> importedMembers;

  final MembersImportInteractor _interactor;
  final List<StreamSubscription<dynamic>> _subscriptions;

  MembersImportBloc._(
      this.importMembers,
      this.importedMembers,
      this._interactor,
      this._subscriptions
      );

  factory MembersImportBloc(MembersImportInteractor interactor) {
    final importMembersController = StreamController<String>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user process importation
      importMembersController.stream.listen(interactor.importMembers),

    ];

    return MembersImportBloc._(
      importMembersController,
      interactor.importedMembers,
      interactor,
      subscriptions,
    );
  }


  void close() {
    importMembers.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}