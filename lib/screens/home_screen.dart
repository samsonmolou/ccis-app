import 'dart:async';

import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/broadcast_list_injector.dart';
import 'package:ccis_app/dependency_injector/member_injector.dart';
import 'package:ccis_app/providers/broadcast_list_bloc_provider.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/screens/broadcastList/broadcast_list_screen.dart';
import 'package:ccis_app/screens/members/member_screen.dart';
import 'package:ccis_app/widgets/shared/loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum AppTab { broadcastList, members }

class HomeScreen extends StatefulWidget {
  final UserRepository repository;
  final MembersInteractor membersInteractor;
  final BroadcastListInteractor broadcastListsInteractor;

  HomeScreen(
      {@required this.repository,
      @required this.membersInteractor,
      @required this.broadcastListsInteractor})
      : super(key: ArchSampleKeys.homeScreen);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  UserBloc usersBloc;
  StreamController<AppTab> tabController;

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
    return StreamBuilder<UserEntity>(
      stream: usersBloc.login(),
      builder: (context, userSnapshot) {
        return StreamBuilder<AppTab>(
            initialData: AppTab.broadcastList,
            stream: tabController.stream,
            builder: (context, activeTabSnapshot) {
              return Scaffold(
                body: userSnapshot.hasData
                    ? activeTabSnapshot.data == AppTab.members
                        ? MemberInjector(
                            membersInteractor: widget.membersInteractor,
                            child: MembersBlocProvider(
                              bloc: MembersListBloc(widget.membersInteractor),
                              child: MemberScreen(),
                            ))
                        : BroadcastListInjector(
                            broadcastListsInteractor:
                                widget.broadcastListsInteractor,
                            child: BroadcastListsBlocProvider(
                              bloc: BroadcastListListBloc(
                                  widget.broadcastListsInteractor),
                              child: BroadcastListScreen(),
                            ),
                          )
                    : LoadingSpinner(),
                bottomNavigationBar: BottomNavigationBar(
                  key: ArchSampleKeys.tabs,
                  currentIndex: AppTab.values.indexOf(activeTabSnapshot.data),
                  onTap: (index) {
                    tabController.add(AppTab.values[index]);
                  },
                  items: AppTab.values.map((tab) {
                    return BottomNavigationBarItem(
                        icon: Icon(
                          tab == AppTab.members ? Icons.people : Icons.list,
                          key: tab == AppTab.members
                              ? ArchSampleKeys.membersTab
                              : ArchSampleKeys.broadcastListTab,
                        ),
                        title: Text(tab == AppTab.members
                            ? ArchSampleLocalizations.of(context).members
                            : ArchSampleLocalizations.of(context)
                                .broadcastList));
                  }).toList(),
                ),
              );
            });
      },
    );
  }

  List<Widget> _buildActions(
      AsyncSnapshot<AppTab> activeTabSnapshot, bool hasData) {
    if (!hasData) return [];

    return [
      IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: null,
      )
    ];
  }
}
