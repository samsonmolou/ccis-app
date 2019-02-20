import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';

class BroadcastItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Broadcast broadcast;
  final BroadcastListInteractor broadcastListInteractor;

  final String _simpleValue1 = 'Action 1';
  final String _simpleValue2 = 'Action 2';
  final String _simpleValue3 = 'Action 3';
  String _simpleValue;


  BroadcastItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.broadcast,
    @required this.broadcastListInteractor
  });

  void showMenuSelection(String value) {
    if (<String>[_simpleValue1, _simpleValue2, _simpleValue3].contains(value))
      _simpleValue = value;
  }

  @override
  Widget build(BuildContext context) {
    BroadcastListBloc broadcastListBloc = BroadcastListBloc(this.broadcastListInteractor);
    return StreamBuilder<BroadcastList>(
      stream: broadcastListBloc.broadcastList(broadcast.broadcastListId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearLoading();

        final broadcastList = snapshot.data;

        return Dismissible(
          key: ArchSampleKeys.broadcastItem(broadcast.id),
          onDismissed: onDismissed,
          background: Container(
              color: Theme.of(context).primaryColor,
              child: const ListTile(
                  leading: Icon(Icons.delete, color: Colors.white, size: 36.0)
              )
          ),
          secondaryBackground: Container(
              color: Theme.of(context).primaryColor,
              child: const ListTile(
                  trailing: Icon(Icons.edit, color: Colors.white, size: 36.0)
              )
          ),
          child: ListTile(
            onTap: onTap,
            title: Text(
              broadcast.name + " #" + broadcast.rank.toString()                                                                                                                                                                                                                   ,
              key: ArchSampleKeys.broadcastItemHead(broadcast.id),
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              '${formatDate(DateTime.parse(broadcast.dateTime),
                  [d, '-', M, '-', yyyy, ' ', HH, ':', nn, ':', ss])} '
                  '- ${broadcastList.name}\n${broadcast.message}',
              key: ArchSampleKeys.memberItemSubhead(broadcast.id),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subhead,

            ),
            isThreeLine: true,

          ),
        );
      },
    );


  }
}
