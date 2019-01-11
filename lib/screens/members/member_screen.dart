import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:ccis_app/helpers/dependency_injection.dart';
import 'package:ccis_app/localization.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/widgets/loading.dart';
import 'package:ccis_app/widgets/member_list.dart';

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

  @override
  void initState() {
    super.initState();

    usersBloc = UserBloc(widget.repository);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membersBloc = MembersBlocProvider.of(context);

    return StreamBuilder<UserEntity>(
      stream: usersBloc.login(),
      builder: (context, userSnapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(BlocLocalizations.of(context).appTitle),
            actions: _buildActions(
              membersBloc,
              userSnapshot.hasData,
            ),
          ),
          body: userSnapshot.hasData
              ? MemberList() : LoadingSpinner(
            key: ArchSampleKeys.membersLoading,
          ),
          floatingActionButton: FloatingActionButton(
              key: ArchSampleKeys.addMemberFab,
              onPressed: null),
        );
      },
    );
  }

  List<Widget> _buildActions(
      MembersListBloc membersBloc,
      bool hasData
      ) {
    if (!hasData) return [];

    return [

    ];
  }
}