import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/widgets/broadcastList/broadcast_list_list.dart';
import 'package:ccis_app/widgets/members/member_search.dart';
import 'package:ccis_app/widgets/shared/navigation_drawer.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';


class BroadcastListScreen extends StatefulWidget {

  BroadcastListScreen()
      : super(key: ArchSampleKeys.broadcastListScreen);

  @override
  State<StatefulWidget> createState() {
    return BroadcastListScreenState();
  }
}

class BroadcastListScreenState extends State<BroadcastListScreen> {

  // Pour la gestion de la recherche d'une liste de diffusion
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
        title: Text(ArchSampleLocalizations.of(context).broadcastList),
        actions: _buildActions(
          membersBloc,
        ),
      ),
      drawer: NavigationDrawer(key: ArchSampleKeys.navigationDrawer),
      body: BroadcastListList(),
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