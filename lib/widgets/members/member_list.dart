import 'package:ccis_app/helpers/dependency_injection.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/widgets/shared/loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/widgets/members/member_item.dart';

class MemberList extends StatelessWidget {
  MemberList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Member>>(
      stream: MembersBlocProvider.of(context).members,
      builder: (context, snapshot) => snapshot.hasData
        ? _buildList(snapshot.data)
        : LoadingSpinner(key: ArchSampleKeys.membersLoading),
    );
  }

  ListView _buildList(List<Member> members) {
    return ListView.builder(
      key: ArchSampleKeys.memberList,
      itemCount: members.length,
      itemBuilder: (BuildContext context, int index) {
        final member = members[index];

        return MemberItem(
          member: member,
          onDismissed: (direction) {

          },
          onTap: () {

          },
        );
      },

    );
  }
}