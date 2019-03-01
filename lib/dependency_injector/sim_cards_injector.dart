import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class SimCardsInjector extends InheritedWidget {
  final SimCardsInteractor simCardsInteractor;


  SimCardsInjector({
    Key key,
    @required this.simCardsInteractor,
    @required Widget child,
  }) : super(key: key, child: child);

  static SimCardsInjector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(SimCardsInjector);

  @override
  bool updateShouldNotify(SimCardsInjector oldWidget) =>
      simCardsInteractor != oldWidget.simCardsInteractor;
}