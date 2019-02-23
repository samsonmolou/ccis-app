import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/user_injector.dart';
import 'package:ccis_app/localization.dart';
import 'package:ccis_app/screens/home_screen.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:flutter/material.dart';


void main({
  @required UserRepository userRepository,
  @required MembersInteractor membersInteractor,
  @required broadcastListsInteractor,
  @required broadcastInteractor,
  @required rankInteractor,
}) {
  runApp(UserInjector(
      userRepository: userRepository,
      child: MaterialApp(
        title: BlocLocalizations().appTitle,
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          InheritedWidgetLocalizationsDelegate(),
        ],
        routes: {
          ArchSampleRoutes.home: (context) {
            return HomeScreen(
              repository: UserInjector.of(context).userRepository,
              membersInteractor: membersInteractor,
              broadcastListsInteractor: broadcastListsInteractor,
              broadcastInteractor: broadcastInteractor,
              rankInteractor: rankInteractor,
            );
          },
        },
      )));
}
