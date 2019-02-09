import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/user_injector.dart';
import 'package:ccis_app/localization.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/screens/home_screen.dart';
import 'package:ccis_app/screens/members/member_add_edit_screen.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:flutter/material.dart';

void main({@required UserRepository userRepository}) {
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
              membersInteractor: MembersInteractor(
                  ReactiveMembersRepositoryFlutter(
                      repository: MembersRepositoryFlutter(
                          sqlite: MemberSqlite()))),
              broadcastListsInteractor: BroadcastListInteractor(
                  ReactiveBroadcastListsRepositoryFlutter(
                    repository: BroadcastListRepositoryFlutter(
                      sqlite: BroadcastListSqlite()
                    )
                  )
              ),
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
      )));
}
