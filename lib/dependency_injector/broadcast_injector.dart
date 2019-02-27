import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class BroadcastInjector extends InheritedWidget {
  final BroadcastInteractor broadcastsInteractor;
  final BroadcastListInteractor broadcastListInteractor;
  final MembersInteractor membersInteractor;
  final RankInteractor rankInteractor;
  final MessagesInteractor messagesInteractor;

  BroadcastInjector({
    Key key,
    @required this.broadcastsInteractor,
    @required this.membersInteractor,
    @required this.broadcastListInteractor,
    @required this.rankInteractor,
    @required this.messagesInteractor,
    @required Widget child,
  }) : super(key: key, child: child);

  static BroadcastInjector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(BroadcastInjector);

  @override
  bool updateShouldNotify(BroadcastInjector oldWidget) =>
      broadcastsInteractor != oldWidget.broadcastsInteractor ||
      membersInteractor != oldWidget.membersInteractor ||
      broadcastListInteractor != oldWidget.broadcastListInteractor ||
      messagesInteractor != oldWidget.messagesInteractor;
}