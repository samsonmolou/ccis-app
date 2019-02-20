import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/broadcast/broadcast_detail_screen.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

class BroadcastSearchDelegate extends SearchDelegate<String> {
  final BroadcastInteractor broadcastInteractor;

  BroadcastSearchDelegate({
    @required this.broadcastInteractor,
  });

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
    final broadcastSearchBloc = BroadcastSearchBloc(this.broadcastInteractor);

    if (query.isEmpty || query.length < 3)
      return new Center(
          child: Text(ArchSampleLocalizations.of(context).searchTextMinimum));

    broadcastSearchBloc.searchBroadcast.add(query);

    return StreamBuilder<List<Broadcast>>(
      stream: broadcastSearchBloc.searchBroadcastResult,
      builder: (context, snapshot) => snapshot.hasData
          ? _SuggestionList(
              query: query,
              onSelected: (String broadcastListId) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return BroadcastDetailScreen(
                        broadcastId: broadcastListId,
                        broadcastInteractor: this.broadcastInteractor,
                        initBloc: () => BroadcastBloc(this.broadcastInteractor),
                      );
                    },
                  ),
                );
              },
              broadcastsSuggestions: snapshot.data,
            )
          : SpinnerLoading(key: ArchSampleKeys.broadcastsLoading),
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
      {this.query, this.onSelected, this.broadcastsSuggestions});

  final String query;
  final ValueChanged<String> onSelected;
  final List<Broadcast> broadcastsSuggestions;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: broadcastsSuggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final Broadcast suggestedBroadcast = broadcastsSuggestions[i];

        return ListTile(
          leading: null,
          title: RichText(
            text: TextSpan(
              text: suggestedBroadcast.message.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestedBroadcast.message.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          subtitle: Text(
            suggestedBroadcast.message,
            key: ArchSampleKeys.broadcastListItemSubhead(suggestedBroadcast.id),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subhead,
          ),
          onTap: () {
            onSelected(suggestedBroadcast.id);
          },
        );
      },
    );
  }
}
