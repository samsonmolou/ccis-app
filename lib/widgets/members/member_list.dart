import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/member_injector.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/screens/members/member_add_edit_screen.dart';
import 'package:ccis_app/screens/members/member_detail_screen.dart';
import 'package:ccis_app/widgets/members/member_item.dart';
import 'package:ccis_app/widgets/shared/loading_spinner.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';


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
            _removeMember(context, member);
          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return MemberDetailScreen(
                    memberId: member.id,
                    initBloc: () =>
                        MemberBloc(MemberInjector.of(context).membersInteractor),
                  );
                },
              ),
            ).then((member) {
              if (member is Member) {
                _showUndoSnackbar(context, member);
              }
            });
          },
        );
      },

    );
  }

  void _removeMember(BuildContext context, Member member) {
    MembersBlocProvider.of(context).deleteMember.add(member.id);

    _showUndoSnackbar(context, member);
  }

  void _editMember(BuildContext context, Member member) {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MemberAddEditScreen(
            member: member,
            updateTodo: MembersBlocProvider.of(context).updateMember.add,
            key: ArchSampleKeys.editMemberScreen,
          );
        },
      ),
    );

  }

  void _showUndoSnackbar(BuildContext context, Member member) {
    final snackBar = SnackBar(
      key: ArchSampleKeys.snackbar,
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).backgroundColor,
      content: Text(
        ArchSampleLocalizations.of(context).memberDeleted(member.fullName),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      action: SnackBarAction(
        key: ArchSampleKeys.snackbarAction(member.id),
        label: ArchSampleLocalizations.of(context).cancel,
        onPressed: () {
          MembersBlocProvider.of(context).addMember.add(member);
        },
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}