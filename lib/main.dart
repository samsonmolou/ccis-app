import 'package:flutter/material.dart';
import 'package:ccis_app/helpers/dependency_injection.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_app/localization.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/members/member_screen.dart';
import 'package:ccis_app/localization.dart';

void main({
  @required MembersInteractor membersInteractor,
  @required UserRepository userRepository
}) {
  runApp(Injector(
      membersInteractor: membersInteractor,
      userRepository: userRepository,
      child: MembersBlocProvider(
          bloc: MembersListBloc(membersInteractor),
          child: MaterialApp(
            title: BlocLocalizations().appTitle,
            theme: ArchSampleTheme.theme,
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              InheritedWidgetLocalizationsDelegate(),
            ],
            routes: {
              ArchSampleRoutes.members: (context) {
                return MemberScreen(
                  repository: Injector
                      .of(context)
                      .userRepository,
                );
              }
            },
          ))
  ));
}
