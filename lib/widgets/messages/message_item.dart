import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/helpers/date_format.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';

class MessageItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Message message;
  final BroadcastInteractor broadcastInteractor;

  final String _simpleValue1 = 'Action 1';
  final String _simpleValue2 = 'Action 2';
  final String _simpleValue3 = 'Action 3';
  String _simpleValue;


  MessageItem({
    @required this.onTap,
    @required this.message,
    @required this.broadcastInteractor
  });

  void showMenuSelection(String value) {
    if (<String>[_simpleValue1, _simpleValue2, _simpleValue3].contains(value))
      _simpleValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: onTap,
      title: Text(
        message.broadcastId + " #" + message.memberId.toString()                                                                                                                                                                                                                   ,
        key: ArchSampleKeys.broadcastItemHead(message.id),
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(
        '${DateFormat.getDateFormat(message.sentAt)}'
            ' - ${message.receivedAt}\n${message.content}',
        key: ArchSampleKeys.memberItemSubhead(message.id),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subhead,

      ),
      isThreeLine: true,
    );
    /*
    BroadcastBloc broadcastListBloc = BroadcastBloc(this.broadcastInteractor);
    return StreamBuilder<BroadcastList>(
      stream: broadcastListBloc.broadcastList(message.broadcastListId),
      builder: (context, snapshot) {

        if (!snapshot.hasData) return Container();

        final broadcastList = snapshot.data;

        return  ListTile(
            onTap: onTap,
            title: Text(
              message.name + " #" + message.rank.toString()                                                                                                                                                                                                                   ,
              key: ArchSampleKeys.broadcastItemHead(message.id),
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              '${DateFormat.getDateFormat(message.dateTime)}'
                  ' - ${broadcastList.name}\n${message.content}',
              key: ArchSampleKeys.memberItemSubhead(message.id),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subhead,

            ),
            isThreeLine: true,
          );
      },
    );
    */

  }
}
