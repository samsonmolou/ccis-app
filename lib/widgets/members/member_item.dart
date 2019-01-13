import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/ccis_app.dart';

class MemberItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Member member;

  MemberItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.memberItem(member.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: new Text(member.firstName[0] + member.secondName[0]),
        ),
        title: Text(
          member.firstName + ' ' + member.secondName,
          key: ArchSampleKeys.memberItemHead(member.id),
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          member.residence + member.bedroomNumber + " - " + member.community,
          key: ArchSampleKeys.memberItemSubhead(member.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),

      ),
    );
  }
}
