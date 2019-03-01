import 'dart:async';

import 'package:sms/sms.dart';
import 'package:ccis_blocs/src/interactors/sim_cards_interactor.dart';

class SimCardsBloc {
  final SimCardsInteractor interactor;

  SimCardsBloc(this.interactor);

  Stream<SimCard> get onSimCardChanged => this.interactor.onSimCardChanged;

  SimCard get selectedSimCard => this.interactor.selectedSimCard;

  void loadSimCards() async {
    this.interactor.loadSimCards();
  }

  void toggleSelectedSim() async {
    this.interactor.toggleSelectedSim();
  }

  void selectSimCard(SimCard sim) {
    this.interactor.selectSimCard(sim);
  }

  Future<List<SimCard>> getSimCards () async {
    return this.interactor.getSimCards();
  }
}
