import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class BroadcastInjector extends InheritedWidget {
  final BroadcastListInteractor broadcastListsInteractor;
  //TODO: Check if it is good to do that
  // I need this in broadcast add screen
  final MembersInteractor membersInteractor;

  BroadcastInjector({
    Key key,
    @required this.broadcastListsInteractor,
    @required this.membersInteractor,
    @required Widget child,
  }) : super(key: key, child: child);

  static BroadcastInjector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(BroadcastInjector);

  @override
  bool updateShouldNotify(BroadcastInjector oldWidget) =>
      broadcastListsInteractor != oldWidget.broadcastListsInteractor;
}