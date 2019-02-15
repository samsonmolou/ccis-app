import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/member_injector.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/screens/members/member_detail_screen.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

class SearchMemberSearchDelegate extends SearchDelegate<String> {
  final MembersInteractor interactor;
  SearchMemberSearchDelegate({@required this.interactor});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: ArchSampleLocalizations.of(context).back,
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //final memberSearchBloc = this.initBloc();
    final memberSearchBloc = MemberSearchBloc(this.interactor);

    if (query.isEmpty || query.length < 3) return new Container();

    memberSearchBloc.searchMember.add(query);

    return StreamBuilder<List<Member>>(
      stream: memberSearchBloc.searchMemberResult,
      builder: (context, snapshot) => snapshot.hasData
          ? _SuggestionList(
              query: query,
              onSelected: (String memberSuggestionId) {
                //TODO: Fix bug on return, we can't edit search field after we comeback from detail view
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return MemberDetailScreen(
                        memberId: memberSuggestionId,
                        initBloc: () => MemberBloc(this.interactor),
                      );
                    },
                  ),
                );
              },
              membersSuggestions: snapshot.data,
            )
          : SpinnerLoading(key: ArchSampleKeys.membersLoading),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? Icon(null)
          : IconButton(
              tooltip: ArchSampleLocalizations.of(context).clear,
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.query, this.onSelected, this.membersSuggestions});

  final String query;
  final ValueChanged<String> onSelected;
  final List<Member> membersSuggestions;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: membersSuggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final Member memberSuggestion = membersSuggestions[i];

        return ListTile(
          leading: null,
          title: RichText(
            text: TextSpan(
              text: memberSuggestion.fullName.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: memberSuggestion.fullName.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          subtitle: Text(
            memberSuggestion.residenceBedroom +
                " - " +
                memberSuggestion.community.name +
                " - " +
                memberSuggestion.phoneNumber,
            key: ArchSampleKeys.memberItemSubhead(memberSuggestion.id),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subhead,
          ),
          onTap: () {
            onSelected(memberSuggestion.id);
          },
        );
      },
    );
  }
}
