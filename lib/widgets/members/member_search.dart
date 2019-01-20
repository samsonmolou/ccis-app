import 'package:flutter/material.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/widgets/shared/loading.dart';

import 'package:ccis_app/screens/members/member_detail_screen.dart';
import 'package:ccis_app/helpers/dependency_injection.dart';

class SearchMemberSearchDelegate extends SearchDelegate<String> {

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

    if(query.isEmpty || query.length < 3)
      return new Container();

    MembersBlocProvider.of(context).searchMember.add(query);

    return StreamBuilder<List<Member>>(
      stream: MembersBlocProvider.of(context).searchMemberResult,
      builder: (context, snapshot) => snapshot.hasData ? _SuggestionList(
          query: query,
          onSelected: (String memberSuggestionId) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                return MemberDetailScreen(
                  memberId: memberSuggestionId,
                  initBloc: () =>
                    MemberBloc(Injector.of(context).membersInteractor),
                );
                },
                ),
            );
          },
          membersSuggestions: snapshot.data,
        ) : LoadingSpinner(key: ArchSampleKeys.membersLoading),
    );
  }

  @override
  Widget buildResults(BuildContext context) {

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

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.integer, this.title, this.searchDelegate});

  final String integer;
  final String title;
  final SearchDelegate<String> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        searchDelegate.close(context, integer);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(title),
              Text(
                '$integer',
                style: theme.textTheme.headline.copyWith(fontSize: 72.0),
              ),
            ],
          ),
        ),
      ),
    );
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
              style: theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: memberSuggestion.fullName.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          subtitle: Text(
            memberSuggestion.residenceBedroom + " - " + memberSuggestion.community + " - " + memberSuggestion.phoneNumber,
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
