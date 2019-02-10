import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MemberItem extends StatelessWidget {
  final Member member;

  MemberItem({
    @required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Checkbox(
        key: ArchSampleKeys.memberItem(member.id),
        value: true,
        onChanged: null,
      ),
      title: Text(
        member.fullName,
        key: ArchSampleKeys.memberItemHead(member.id),
      ),
      subtitle: Text(
        member.residenceBedroom +
            " - " +
            member.community.name +
            " - " +
            member.phoneNumber,
        key: ArchSampleKeys.memberItemSubhead(member.id),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
