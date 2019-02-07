library dependency_injector;

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class Injector extends InheritedWidget {
  final MembersInteractor membersInteractor;
  final UserRepository userRepository;

  Injector({
    Key key,
    @required this.membersInteractor,
    @required this.userRepository,
    @required Widget child,
  }) : super(key: key, child: child);

  static Injector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Injector);

  @override
  bool updateShouldNotify(Injector oldWidget) =>
      membersInteractor != oldWidget.membersInteractor ||
          userRepository != oldWidget.userRepository;
}