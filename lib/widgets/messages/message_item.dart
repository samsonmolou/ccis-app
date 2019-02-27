import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';
import 'package:ccis_app/helpers/parser.dart';

class MessageItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Message message;
  final MessagesInteractor messageInteractor;
  final MembersInteractor membersInteractor;

  final String _simpleValue1 = 'Action 1';
  final String _simpleValue2 = 'Action 2';
  final String _simpleValue3 = 'Action 3';
  String _simpleValue;


  MessageItem({
    @required this.onTap,
    @required this.message,
    @required this.messageInteractor,
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

        return  ListTile(
          dense: true,
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          title: Text(
            '${member.firstName} ${member.secondName}',
            key: ArchSampleKeys.broadcastItemHead(message.id), //TODO: Change this to messageItem
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            '${member.phoneNumber} - ${member.community.name}\n${Parser.parse(member, message.content)}',
            key: ArchSampleKeys.memberItemSubhead(message.id),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subhead,

          ),
          trailing: message.isWaiting == 1 ? Icon(Icons.hourglass_empty) : message.isSent == 1 ? Icon(Icons.hourglass_full) : message.isReceived == 1 ? Icon(Icons.check) : Icon(Icons.error),
          isThreeLine: true,
        );
      },
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
