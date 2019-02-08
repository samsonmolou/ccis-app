import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/member_dependency_injection.dart';
import 'package:ccis_app/localization.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/screens/home_screen.dart';
import 'package:ccis_app/screens/members/member_add_edit_screen.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:flutter/material.dart';

void main(
    {@required MembersInteractor membersInteractor,
    @required UserRepository userRepository}) {
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
              ArchSampleRoutes.home: (context) {
                return HomeScreen(
                  repository: Injector.of(context).userRepository,
                );
              },
              ArchSampleRoutes.addMember: (context) {
                return MemberAddEditScreen(
                  addMember: MembersBlocProvider.of(context).addMember.add,
                  communitiesInteractor: CommunitiesInteractor(
                      ReactiveCommunitiesRepositoryFlutter(
                          repository: CommunitiesRepositoryFlutter(
                              communitiesMetadata: CommunitiesMetadata()))),
                  studiesInteractor: StudiesInteractor(
                      ReactiveStudiesRepositoryFlutter(
                          repository: StudiesRepositoryFlutter(
                              studiesMetadata: StudiesMetadata()))),
                );
              },
            },
          ))));
}
