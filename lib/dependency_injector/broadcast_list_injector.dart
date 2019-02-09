import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class BroadcastListInjector extends InheritedWidget {
  final BroadcastListInteractor broadcastListsInteractor;

  BroadcastListInjector({
    Key key,
    @required this.broadcastListsInteractor,
    @required Widget child,
  }) : super(key: key, child: child);

  static BroadcastListInjector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(BroadcastListInjector);

  @override
  bool updateShouldNotify(BroadcastListInjector oldWidget) =>
      broadcastListsInteractor != oldWidget.broadcastListsInteractor;
}