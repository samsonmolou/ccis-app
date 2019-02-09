import 'package:ccis_repository/ccis_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class UserInjector extends InheritedWidget {
  final UserRepository userRepository;

  UserInjector({
    Key key,
    @required this.userRepository,
    @required Widget child,
  }) : super(key: key, child: child);

  static UserInjector of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(UserInjector);

  @override
  bool updateShouldNotify(UserInjector oldWidget) =>
          userRepository != oldWidget.userRepository;
}