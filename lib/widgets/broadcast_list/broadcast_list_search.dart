import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/broadcast_list/broadcast_list_detail_screen.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

class BroadcastListSearchDelegate extends SearchDelegate<String> {
  final BroadcastListInteractor broadcastListinteractor;
  final MembersInteractor membersInteractor;
  BroadcastListSearchDelegate(
      {@required this.broadcastListinteractor,
      @required this.membersInteractor});

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
    final broadcastListSearchBloc =
        BroadcastListSearchBloc(this.broadcastListinteractor);

    if (query.isEmpty || query.length < 3) return new Container();

    broadcastListSearchBloc.searchBroadcastList.add(query);

    return StreamBuilder<List<BroadcastList>>(
      stream: broadcastListSearchBloc.searchBroadcastListResult,
      builder: (context, snapshot) => snapshot.hasData
          ? _SuggestionList(
              query: query,
              onSelected: (String broadcastListSuggestionId) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return BroadcastListDetailScreen(
                          broadcastListId: broadcastListSuggestionId,
                          membersInteractor: this.membersInteractor,
                          broadcastListInteractor: this.broadcastListinteractor,
                          initBloc: () =>
                              BroadcastListBloc(this.broadcastListinteractor),
                          initSearchBloc: () => BroadcastListAddEditSearchBloc(
                              this.membersInteractor, this.broadcastListinteractor));
                    },
                  ),
                );
              },
              broadcastListsSuggestions: snapshot.data,
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
  const _SuggestionList(
      {this.query, this.onSelected, this.broadcastListsSuggestions});

  final String query;
  final ValueChanged<String> onSelected;
  final List<BroadcastList> broadcastListsSuggestions;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: broadcastListsSuggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final BroadcastList suggestedBroadcastList =
            broadcastListsSuggestions[i];

        return ListTile(
          leading: null,
          title: RichText(
            text: TextSpan(
              text: suggestedBroadcastList.name.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestedBroadcastList.name.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          subtitle: Text(
            suggestedBroadcastList.name,
            key: ArchSampleKeys.broadcastListItemSubhead(
                suggestedBroadcastList.id),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subhead,
          ),
          onTap: () {
            onSelected(suggestedBroadcastList.id);
          },
        );
      },
    );
  }
}
