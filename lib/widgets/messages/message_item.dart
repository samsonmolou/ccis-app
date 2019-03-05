import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/helpers/date_format.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';

class MessageItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Message message;
  final MembersInteractor membersInteractor;

  final String _simpleValue1 = 'Action 1';
  final String _simpleValue2 = 'Action 2';
  final String _simpleValue3 = 'Action 3';
  String _simpleValue;

  MessageItem({
    @required this.onTap,
    @required this.message,
    @required this.membersInteractor
  });

  void showMenuSelection(String value) {
    if (<String>[_simpleValue1, _simpleValue2, _simpleValue3].contains(value))
      _simpleValue = value;
  }

  @override
  Widget build(BuildContext context) {
    MemberBloc memberBloc = MemberBloc(this.membersInteractor);

    return StreamBuilder<Member>(
      stream: memberBloc.member(this.message.memberId).where((member) => member != null),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearLoading();

        final member = snapshot.data;

        return ListTile(
          onTap: onTap,
          title: Text(
            member.fullName,
            key: ArchSampleKeys.broadcastItemHead(message.id),
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            '${DateFormat.getDateFormat(message.sentAt)}'
                ' - ${member.phoneNumber}\n${message.content}',
            key: ArchSampleKeys.memberItemSubhead(message.id),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subhead,
          ),
          isThreeLine: true,
          trailing: message.isWaiting == 1
              ? Icon(Icons.schedule, color: Theme.of(context).accentColor,)
              : message.isSent == 1
              ? Icon(Icons.done, color: Theme.of(context).accentColor)
              : message.isReceived == 1
              ? Icon(Icons.done_all, color: Theme.of(context).accentColor)
              : Icon(Icons.sms_failed, color: Theme.of(context).errorColor),
        );
      },
    );

  }
}
