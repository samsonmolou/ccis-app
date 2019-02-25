import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/broadcast_injector.dart';
import 'package:ccis_app/providers/broadcasts_bloc_provider.dart';
import 'package:ccis_app/screens/broadcast/broadcast_add_edit_screen.dart';
import 'package:ccis_app/widgets/broadcasts/broadcasts_list.dart';
import 'package:ccis_app/widgets/broadcasts/broadcast_search.dart';
import 'package:ccis_app/widgets/shared/navigation_drawer.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

class BroadcastScreen extends StatefulWidget {
  BroadcastScreen() : super(key: ArchSampleKeys.broadcastScreen);

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
    final broadcastsBloc = BroadcastsBlocProvider.of(context);
    // Pour la gestion de la recherche d'une liste de diffusion
    //TODO: Revoir le passage des interacteurs
    BroadcastSearchDelegate delegate = BroadcastSearchDelegate(
      broadcastInteractor: BroadcastInjector.of(context).broadcastsInteractor,
      rankInteractor: BroadcastInjector.of(context).rankInteractor,
      broadcastListInteractor: BroadcastInjector.of(context).broadcastListInteractor
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).broadcasts),
        actions: _buildActions(delegate),
      ),
      drawer: NavigationDrawer(key: ArchSampleKeys.navigationDrawer),
      body: BroadcastsList(),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addBroadcastFab,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) {
              return BroadcastAddEditScreen(
                addBroadcast: broadcastsBloc.addBroadcast.add,
                broadcastInteractor:
                    BroadcastInjector.of(context).broadcastsInteractor,
                rankInteractor: BroadcastInjector.of(context).rankInteractor,
                broadcastListInteractor: BroadcastInjector.of(context).broadcastListInteractor,
                key: ArchSampleKeys.addBroadcastListScreen,
              );
            },
          ));
        },
        child: Icon(Icons.message),
        tooltip: ArchSampleLocalizations.of(context).addBroadcastList,
      ),
    );
  }

  List<Widget> _buildActions(BroadcastSearchDelegate delegate) {
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
