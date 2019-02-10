import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/broadcast_list_injector.dart';
import 'package:ccis_app/providers/broadcast_list_bloc_provider.dart';
import 'package:ccis_app/screens/broadcastList/broadcast_list_add_edit_screen.dart';
import 'package:ccis_app/screens/broadcastList/broadcast_list_detail_screen.dart';
import 'package:ccis_app/widgets/broadcastList/broadcast_list_item.dart';
import 'package:ccis_app/widgets/shared/loading_spinner.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';


class BroadcastListList extends StatelessWidget {
  BroadcastListList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BroadcastList>>(
      stream: BroadcastListsBlocProvider.of(context).broadcastLists,
      builder: (context, snapshot) => snapshot.hasData
          ? _buildList(snapshot.data)
          : LoadingSpinner(key: ArchSampleKeys.broadcastListsLoading),
    );
  }

  ListView _buildList(List<BroadcastList> broadcastLists) {
    return ListView.builder(
      key: ArchSampleKeys.broadcastLists,
      itemCount: broadcastLists.length,
      itemBuilder: (BuildContext context, int index) {
        final broadcastList = broadcastLists[index];

        return BroadcastListItem(
          broadcastList: broadcastList,
          onDismissed: (direction) {
            _removeBroadcastList(context, broadcastList);
          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return BroadcastListDetailScreen(
                    broadcastListId: broadcastList.id,
                    initBloc: () =>
                        BroadcastListBloc(BroadcastListInjector.of(context).broadcastListsInteractor),
                  );
                },
              ),
            ).then((broadcastList) {
              if (broadcastList is BroadcastList) {
                _showUndoSnackbar(context, broadcastList);
              }
            });
          },
        );
      },

    );
  }

  void _removeBroadcastList(BuildContext context, BroadcastList broadcastList) {
    BroadcastListsBlocProvider.of(context).deleteBroadcastList.add(broadcastList.id);

    _showUndoSnackbar(context, broadcastList);
  }

  void _editMember(BuildContext context, BroadcastList broadcastList) {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BroadcastListAddEditScreen(
            broadcastList: broadcastList,
            updateBroadcastList: BroadcastListsBlocProvider.of(context).updateBroadcastList.add,
            key: ArchSampleKeys.editMemberScreen,
            initSearchBloc: () => BroadcastListAddEditSearchBloc(BroadcastListInjector.of(context).membersInteractor),
          );
        },
      ),
    );

  }

  void _showUndoSnackbar(BuildContext context, BroadcastList broadcastList) {
    final snackBar = SnackBar(
      key: ArchSampleKeys.snackbar,
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).backgroundColor,
      content: Text(
        ArchSampleLocalizations.of(context).memberDeleted(broadcastList.name),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      action: SnackBarAction(
        key: ArchSampleKeys.snackbarAction(broadcastList.id),
        label: ArchSampleLocalizations.of(context).cancel,
        onPressed: () {
          BroadcastListsBlocProvider.of(context).addBroadcastList.add(broadcastList);
        },
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}