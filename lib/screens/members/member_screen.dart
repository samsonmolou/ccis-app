import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:ccis_app/dependency_injector/member_dependency_injection.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/widgets/shared/loading.dart';
import 'package:ccis_app/widgets/shared/navigation_drawer.dart';
import 'package:ccis_app/widgets/members/member_list.dart';
import 'package:ccis_app/widgets/members/member_search.dart';


class MemberScreen extends StatefulWidget {

  MemberScreen()
      : super(key: ArchSampleKeys.memberScreen);

  @override
  State<StatefulWidget> createState() {
    return MemberScreenState();
  }
}

class MemberScreenState extends State<MemberScreen> {

  // Pour la gestion de la recherche des membres
  final SearchMemberSearchDelegate _delegate = SearchMemberSearchDelegate();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membersBloc = MembersBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).members),
        actions: _buildActions(
          membersBloc,
        ),
      ),
      drawer: NavigationDrawer(key: ArchSampleKeys.navigationDrawer),
      body: MemberList(),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addMemberFab,
        onPressed: () {
          Navigator.pushNamed(context, ArchSampleRoutes.addMember);
        },
        child: Icon(Icons.add),
        tooltip: ArchSampleLocalizations.of(context).addMember,
      ),
    );
  }

  List<Widget> _buildActions(
      MembersListBloc membersBloc,
      ) {
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