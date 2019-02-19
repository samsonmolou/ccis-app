import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/broadcast_list_injector.dart';
import 'package:ccis_app/providers/broadcast_list_bloc_provider.dart';
import 'package:ccis_app/screens/broadcast_list/broadcast_list_add_edit_screen.dart';
import 'package:ccis_app/widgets/broadcast_list/broadcast_list_search.dart';
import 'package:ccis_app/widgets/shared/navigation_drawer.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

class BroadcastScreen extends StatefulWidget {
  BroadcastScreen() : super(key: ArchSampleKeys.broadcastListScreen);

  @override
  State<StatefulWidget> createState() {
    return BroadcastScreenState();
  }
}

class BroadcastScreenState extends State<BroadcastScreen> {
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
    final broadcastListsBloc = BroadcastListsBlocProvider.of(context);
    // Pour la gestion de la recherche d'une liste de diffusion
    //TODO: Revoir le passage des interacteurs
    BroadcastListSearchDelegate delegate = BroadcastListSearchDelegate(
        broadcastListinteractor:
        BroadcastListInjector.of(context).broadcastListsInteractor,
        membersInteractor: BroadcastListInjector.of(context).membersInteractor);

    return Scaffold(
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).broadcast),
        actions: _buildActions(delegate),
      ),
      drawer: NavigationDrawer(key: ArchSampleKeys.navigationDrawer),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addBroadcastListFab,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) {
              return BroadcastListAddEditScreen(
                addBroadcastList: broadcastListsBloc.addBroadcastList.add,
                broadcastListsInteractor: BroadcastListInjector.of(context).broadcastListsInteractor,
                key: ArchSampleKeys.addBroadcastListScreen,
                initSearchBloc: () => BroadcastListAddEditSearchBloc(
                    BroadcastListInjector.of(context).membersInteractor, BroadcastListInjector.of(context).broadcastListsInteractor),
              );
            },
          ));
        },
        child: Icon(Icons.message),
        tooltip: ArchSampleLocalizations.of(context).addBroadcastList,
      ),
    );
  }

  List<Widget> _buildActions(BroadcastListSearchDelegate delegate) {
    return [
      IconButton(
        tooltip: ArchSampleLocalizations.of(context).searchBroadcastList,
        icon: const Icon(Icons.search),
        onPressed: () async {
          await showSearch<String>(
            context: context,
            delegate: delegate,
          );
        },
      )
    ];
  }
}
