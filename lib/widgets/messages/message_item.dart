import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/helpers/date_format.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';

class MessageItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Message message;

  final String _simpleValue1 = 'Action 1';
  final String _simpleValue2 = 'Action 2';
  final String _simpleValue3 = 'Action 3';
  String _simpleValue;

  MessageItem({
    @required this.onTap,
    @required this.message,
  });

  void showMenuSelection(String value) {
    if (<String>[_simpleValue1, _simpleValue2, _simpleValue3].contains(value))
      _simpleValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        message.memberId + " " + message.memberId,
        key: ArchSampleKeys.broadcastItemHead(message.id),
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(
        '${DateFormat.getDateFormat(message.sentAt)}'
            ' - ${message.content}\n${message.content}',
        key: ArchSampleKeys.memberItemSubhead(message.id),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subhead,
      ),
      isThreeLine: true,
      trailing: message.isWaiting == 1
          ? Icon(Icons.schedule)
          : message.isSent == 1
              ? Icon(Icons.done)
              : message.isReceived == 1
                  ? Icon(Icons.done_all)
                  : Icon(Icons.sms_failed),
    );
  }
}
