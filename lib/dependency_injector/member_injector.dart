import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class MemberInjector extends InheritedWidget {
  final MembersInteractor membersInteractor;

  MemberInjector({
    Key key,
    @required this.membersInteractor,
    @required Widget child,
  }) : super(key: key, child: child);

  static MemberInjector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(MemberInjector);

  @override
  bool updateShouldNotify(MemberInjector oldWidget) =>
      membersInteractor != oldWidget.membersInteractor;
}