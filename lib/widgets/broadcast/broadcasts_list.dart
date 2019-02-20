import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/broadcast_injector.dart';
import 'package:ccis_app/providers/broadcasts_bloc_provider.dart';
import 'package:ccis_app/screens/broadcast/broadcast_add_edit_screen.dart';
import 'package:ccis_app/screens/broadcast/broadcast_detail_screen.dart';
import 'package:ccis_app/widgets/broadcast/broadcast_item.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

class BroadcastsList extends StatelessWidget {
  BroadcastsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Broadcast>>(
      stream: BroadcastsBlocProvider.of(context).broadcasts,
      builder: (context, snapshot) => snapshot.hasData
          ? _buildList(snapshot.data)
          : SpinnerLoading(key: ArchSampleKeys.broadcastListsLoading),
    );
  }

  ListView _buildList(List<Broadcast> broadcasts) {
    broadcasts.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return ListView.builder(
      key: ArchSampleKeys.broadcastLists,
      itemCount: broadcasts.length,
      itemBuilder: (BuildContext context, int index) {
        final broadcast = broadcasts[index];

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
          ),
          child: BroadcastItem(
            broadcast: broadcast,
            onDismissed: (direction) {
              _removeBroadcastList(context, broadcast);
            },
            broadcastListInteractor: BroadcastInjector.of(context).broadcastListInteractor,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return BroadcastDetailScreen(
                      broadcastId: broadcast.id,
                      broadcastInteractor:
                      BroadcastInjector.of(context).broadcastsInteractor,
                      rankInteractor: BroadcastInjector.of(context).rankInteractor,
                      broadcastListInteractor: BroadcastInjector.of(context).broadcastListInteractor,
                      initBloc: () => BroadcastBloc(
                          BroadcastInjector.of(context).broadcastsInteractor),
                    );
                  },
                ),
              ).then((broadcast) {
                if (broadcast is Broadcast) {
                  _showUndoSnackbar(context, broadcast);
                }
              });
            },
          ),
        );
      },
    );
  }

  void _removeBroadcastList(BuildContext context, Broadcast broadcast) {
    BroadcastsBlocProvider.of(context).deleteBroadcast.add(broadcast.id);

    _showUndoSnackbar(context, broadcast);
  }

  void _editMember(BuildContext context, Broadcast broadcast) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BroadcastAddEditScreen(
            broadcast: broadcast,
            updateBroadcast:
                BroadcastsBlocProvider.of(context).updateBroadcast.add,
            broadcastInteractor:
                BroadcastInjector.of(context).broadcastsInteractor,
            rankInteractor:  BroadcastInjector.of(context).rankInteractor,
            broadcastListInteractor: BroadcastInjector.of(context).broadcastListInteractor,
            key: ArchSampleKeys.editBroadcastScreen,
          );
        },
      ),
    );
  }

  void _showUndoSnackbar(BuildContext context, Broadcast broadcast) {
    final snackBar = SnackBar(
      key: ArchSampleKeys.snackbar,
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).backgroundColor,
      content: Text(
        ArchSampleLocalizations.of(context).memberDeleted(broadcast.message),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      action: SnackBarAction(
        key: ArchSampleKeys.snackbarAction(broadcast.id),
        label: ArchSampleLocalizations.of(context).cancel,
        onPressed: () {
          BroadcastsBlocProvider.of(context).addBroadcast.add(broadcast);
        },
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
