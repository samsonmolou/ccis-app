import 'package:flutter/material.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/widgets/shared/loading.dart';

class SearchMemberSearchDelegate extends SearchDelegate<String> {
  final List<String> _data = <String>['Molou Samson', 'Livai Ackerman', 'Mikasa Ackerman'];
  final List<String> _history = <String>[];


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
          onSelected: (String suggestion) {
            query = suggestion;
            showResults(context);
          },
          membersSuggestions: snapshot.data,
        ) : LoadingSpinner(key: ArchSampleKeys.membersLoading),
    );
    /*
    return _SuggestionList(
      query: query,
      suggestions: suggestions.map<String>((String i) => '$i').toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    ); */
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searched = query;
    if (searched == null || !_data.contains(searched)) {
      return Center(
        child: Text(
          '"$query"\n is not a valid integer between 0 and 100,000.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }


    return ListView(
      children: <Widget>[
        _ResultCard(
          title: 'This integer',
          integer: searched,
          searchDelegate: this,
        ),
        _ResultCard(
          title: 'Next integer',
          integer: searched,
          searchDelegate: this,
        ),
        _ResultCard(
          title: 'Previous integer',
          integer: searched,
          searchDelegate: this,
        ),
      ],
    );
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
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: memberSuggestion.fullName.substring(0, query.length),
              style: theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: ' ' + memberSuggestion.fullName.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(memberSuggestion.id);
          },
        );
      },
    );
  }
}
