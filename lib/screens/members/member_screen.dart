import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:ccis_app/helpers/dependency_injection.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/widgets/shared/loading.dart';
import 'package:ccis_app/widgets/shared/navigation_drawer.dart';
import 'package:ccis_app/widgets/members/member_list.dart';
import 'package:ccis_app/widgets/members/member_search.dart';


enum AppTab { members }

class MemberScreen extends StatefulWidget {
  final UserRepository repository;

  MemberScreen({@required this.repository})
      : super(key: ArchSampleKeys.memberScreen);

  @override
  State<StatefulWidget> createState() {
    return MemberScreenState();
  }
}

class MemberScreenState extends State<MemberScreen> {
  UserBloc usersBloc;
  StreamController<AppTab> tabController;
  final SearchMemberSearchDelegate _delegate = SearchMemberSearchDelegate();

  @override
  void initState() {
    super.initState();

    usersBloc = UserBloc(widget.repository);
    tabController = StreamController<AppTab>();
  }

  @override
  void dispose() {
    tabController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membersBloc = MembersBlocProvider.of(context);

    return StreamBuilder<UserEntity>(
      stream: usersBloc.login(),
      builder: (context, userSnapshot) {
        return StreamBuilder<AppTab>(
          initialData: AppTab.members,
          stream: tabController.stream,
          builder: (context, activeTabSnapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(ArchSampleLocalizations.of(context).members),
                
                actions: _buildActions(
                  membersBloc,
                  activeTabSnapshot,
                  userSnapshot.hasData,
                ),
              ),
              drawer: NavigationDrawer(key: ArchSampleKeys.navigationDrawer),
              body: userSnapshot.hasData
                  ? MemberList()
                  : LoadingSpinner(
                key: ArchSampleKeys.membersLoading,
              ),
              floatingActionButton: FloatingActionButton(
                  key: ArchSampleKeys.addMemberFab,
                  onPressed: () {
                    Navigator.pushNamed(context, ArchSampleRoutes.addMember);
                  },
                  child: Icon(Icons.add),
                  tooltip: ArchSampleLocalizations.of(context).addMember,
              ),
            );
          });
      },
    );
  }

  List<Widget> _buildActions(
      MembersListBloc membersBloc,
      AsyncSnapshot<AppTab> activeTabSnapshot,
      bool hasData
      ) {
    if (!hasData) return [];


    return [
      IconButton(
        tooltip: ArchSampleLocalizations.of(context).searchMember,
        icon: const Icon(Icons.search),
        onPressed: () async {
          await showSearch<String>(
            context: context,
            delegate: _delegate,
          );
        },
      )
    ];
  }
}