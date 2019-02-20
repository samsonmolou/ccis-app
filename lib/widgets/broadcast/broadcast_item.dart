import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BroadcastItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Broadcast broadcast;

  final String _simpleValue1 = 'Action 1';
  final String _simpleValue2 = 'Action 2';
  final String _simpleValue3 = 'Action 3';
  String _simpleValue;


  BroadcastItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.broadcast,
  });

  void showMenuSelection(String value) {
    if (<String>[_simpleValue1, _simpleValue2, _simpleValue3].contains(value))
      _simpleValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.memberItem(broadcast.id),
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
          ArchSampleLocalizations.of(context).broadcast + " #" + broadcast.rank.toString()                                                                                                                                                                                                                   ,
          key: ArchSampleKeys.broadcastItemHead(broadcast.id),
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          '${broadcast.dateHeure} - ${broadcast.broadcastListId}\n${broadcast.message}',
          key: ArchSampleKeys.memberItemSubhead(broadcast.id),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,

        ),
        isThreeLine: true,

      ),
    );
  }
}
