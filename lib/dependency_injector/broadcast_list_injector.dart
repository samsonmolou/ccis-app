import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class BroadcastListInjector extends InheritedWidget {
  final BroadcastListInteractor broadcastListsInteractor;
  //TODO: Check if it is good to do that
  // I need this in broadcast add screen
  final MembersInteractor membersInteractor;

  BroadcastListInjector({
    Key key,
    @required this.broadcastListsInteractor,
    @required this.membersInteractor,
    @required Widget child,
  }) : super(key: key, child: child);

  static BroadcastListInjector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(BroadcastListInjector);

  @override
  bool updateShouldNotify(BroadcastListInjector oldWidget) =>
      broadcastListsInteractor != oldWidget.broadcastListsInteractor;
}