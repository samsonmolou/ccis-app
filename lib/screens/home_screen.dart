import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ccis_app/localization.dart';
import 'package:ccis_app/dependency_injector/member_dependency_injection.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/widgets/shared/loading.dart';
import 'package:ccis_app/widgets/shared/navigation_drawer.dart';
import 'package:ccis_app/widgets/members/member_list.dart';
import 'package:ccis_app/widgets/members/member_search.dart';
import 'package:ccis_app/screens/members/member_screen.dart';
import 'package:ccis_app/screens/broadcastList/broadcast_list_screen.dart';


enum AppTab { broadcastList, members  }

class HomeScreen extends StatefulWidget {
  final UserRepository repository;

  HomeScreen({@required this.repository})
      : super(key: ArchSampleKeys.memberScreen);

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
            initialData: AppTab.members,
            stream: tabController.stream,
            builder: (context, activeTabSnapshot) {
              return Scaffold(
                body: userSnapshot.hasData
                    ? activeTabSnapshot.data == AppTab.members ? MemberScreen()
                    : BroadcastListScreen() : LoadingSpinner(),
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
                        key: tab == AppTab.members ? ArchSampleKeys.membersTab
                          : ArchSampleKeys.broadcastListTab,
                      ),
                      title: Text(
                        tab == AppTab.members ? ArchSampleLocalizations.of(context).members
                              : ArchSampleLocalizations.of(context).broadcastList
                      )
                    );
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
