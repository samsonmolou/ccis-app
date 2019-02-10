import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MemberItem extends StatelessWidget {
  final Member member;
  final bool checkboxValue;
  final ValueChanged<bool> onCheckboxChanged;

  MemberItem({
    @required this.member,
    @required this.checkboxValue,
    @required this.onCheckboxChanged
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Checkbox(
        key: ArchSampleKeys.memberItem(member.id),
        value: checkboxValue,
        onChanged: onCheckboxChanged,
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
