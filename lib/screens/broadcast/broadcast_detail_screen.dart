import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/broadcast/broadcast_add_forward_screen.dart';
import 'package:ccis_app/widgets/broadcasts/broadcast_item.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';
import 'package:ccis_app/widgets/broadcasts/broadcast_detail_details.dart';
import 'package:ccis_app/widgets/shared/sliver_category.dart';
import 'package:ccis_app/widgets/broadcasts/broadcast_detail_messages.dart';
import 'package:ccis_app/widgets/messages/message_item.dart';

import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ccis_app/helpers/date_format.dart';

class BroadcastDetailScreen extends StatefulWidget {
  final String broadcastId;
  final BroadcastBloc Function() initBloc;
  final BroadcastInteractor broadcastInteractor;
  final RankInteractor rankInteractor;
  final BroadcastListInteractor broadcastListInteractor;
  final MessagesInteractor messagesInteractor;
  final MembersInteractor membersInteractor;

  BroadcastDetailScreen(
      {@required this.broadcastId,
      @required this.initBloc,
      @required this.broadcastInteractor,
      @required this.rankInteractor,
      @required this.broadcastListInteractor,
      @required this.messagesInteractor,
      @required this.membersInteractor})
      : super(key: ArchSampleKeys.broadcastDetailsScreen);

  @override
  BroadcastDetailScreenState createState() {
    return BroadcastDetailScreenState();
  }
}

class BroadcastDetailScreenState extends State<BroadcastDetailScreen>
    with TickerProviderStateMixin {
  BroadcastBloc _broadcastBloc;
  BroadcastListBloc _broadcastListBloc;
  MessagesSearchBloc _messagesSearchBloc;

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  TabController _controller;
  List<_Tab> _allTabs;
  final TextEditingController _searchBoxController =
      new TextEditingController();
  String _query;

  @override
  void initState() {
    super.initState();
    _broadcastBloc = widget.initBloc();
    _broadcastListBloc = BroadcastListBloc(widget.broadcastListInteractor);
    _query = "";
    _messagesSearchBloc =
        MessagesSearchBloc(widget.messagesInteractor, widget.membersInteractor);
    _messagesSearchBloc.query.add(_query);
  }

  @override
  void dispose() {
    _broadcastBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _allTabs = <_Tab>[
      _Tab(
          key: ArchSampleKeys.broadcastDetailDetailsTab,
          text: ArchSampleLocalizations.of(context).broadcastDetailDetailsTab),
      _Tab(
          key: ArchSampleKeys.broadcastDetailMessagesTab,
          text: ArchSampleLocalizations.of(context).broadcastDetailReportTab)
    ];
    _controller = TabController(length: _allTabs.length, vsync: this);
    return StreamBuilder<Broadcast>(
      stream: _broadcastBloc
          .broadcast(widget.broadcastId)
          .where((broadcast) => broadcast != null),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SpinnerLoading();
        final broadcast = snapshot.data;
        return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(broadcast.name + " #" + broadcast.rank.toString()),
              actions: [
                IconButton(
                  key: ArchSampleKeys.deleteBroadcastButton,
                  tooltip: ArchSampleLocalizations.of(context).deleteBroadcast,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _broadcastBloc.deleteBroadcast.add(broadcast.id);
                    Navigator.pop(context, broadcast);
                  },
                ),
                IconButton(
                  key: ArchSampleKeys.forwardBroadcastButton,
                  tooltip: ArchSampleLocalizations.of(context).forwardBroadcast,
                  icon: Icon(Icons.forward),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return BroadcastAddForwardScreen(
                            broadcast: broadcast,
                            broadcastInteractor: widget.broadcastInteractor,
                            broadcastListInteractor:
                                widget.broadcastListInteractor,
                            messagesInteractor: widget.messagesInteractor,
                            membersInteractor: widget.membersInteractor,
                            rankInteractor: widget.rankInteractor,
                            updateBroadcast: _broadcastBloc.updateBroadcast.add,
                            addBroadcast: _broadcastBloc.addBroadcast.add,
                            key: ArchSampleKeys.editBroadcastScreen,
                          );
                        },
                      ),
                    );
                  },
                )
              ],
              bottom: TabBar(
                  controller: _controller,
                  tabs: _allTabs.map<Tab>((_Tab page) {
                    return Tab(text: page.text);
                  }).toList()),
            ),
            body: TabBarView(
                controller: _controller,
                children: _allTabs.map<Widget>((_Tab tab) {
                  if (tab.key == ArchSampleKeys.broadcastDetailDetailsTab)
                    return new CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                            AnnotatedRegion<SystemUiOverlayStyle>(
                              value: SystemUiOverlayStyle.dark,
                              child: SliverCategory(
                                icon: Icons.label,
                                children: <Widget>[
                                  SliverItem(
                                    lines: <String>[
                                      '${broadcast.name} #${broadcast.rank.toString()}',
                                      ArchSampleLocalizations.of(context)
                                          .newBroadcastNameLabel
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            StreamBuilder<BroadcastList>(
                              stream: _broadcastListBloc
                                  .broadcastList(broadcast.broadcastListId)
                                  .where(
                                      (broadcastList) => broadcastList != null),
                              builder: (context, snapshot) => snapshot.hasData
                                  ? SliverCategory(
                                      icon: Icons.list,
                                      children: <Widget>[
                                        SliverItem(
                                          lines: <String>[
                                            snapshot.data.name,
                                            ArchSampleLocalizations.of(context)
                                                .newBroadcastListNameLabel
                                          ],
                                        ),
                                      ],
                                    )
                                  : Container(
                                      height: 0,
                                      width: 0,
                                    ),
                            ),
                            SliverCategory(
                              icon: Icons.calendar_today,
                              children: <Widget>[
                                SliverItem(
                                  lines: <String>[
                                    DateFormat.getDateFormat(
                                        broadcast.dateTime),
                                    ArchSampleLocalizations.of(context)
                                        .newBroadcastDateTimeLabel
                                  ],
                                ),
                              ],
                            ),
                            SliverCategory(
                              icon: Icons.message,
                              children: <Widget>[
                                SliverItem(
                                  lines: <String>[
                                    broadcast.message,
                                    ArchSampleLocalizations.of(context)
                                        .newBroadcastMessageLabel
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        )
                      ],
                    );
                  else if (tab.key == ArchSampleKeys.broadcastDetailMessagesTab)
                    return new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            key: ArchSampleKeys.addEditSearchField,
                            controller: _searchBoxController,
                            onChanged: _messagesSearchBloc.query.add,
                            decoration: InputDecoration(
                              hintText: ArchSampleLocalizations.of(context)
                                  .searchMember,
                              filled: true,
                              hasFloatingPlaceholder: false,
                              suffixIcon: _query != ""
                                  ? IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        _searchBoxController.clear();
                                        _messagesSearchBloc.query.add('');
                                      },
                                    )
                                  : null,
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(),
                        StreamBuilder<List<Message>>(
                          stream: _messagesSearchBloc.queryResult,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return SpinnerLoading();

                            List<Message> messages = snapshot.data;

                            // On filtre les messages pour retenir uniquement ceux appartenant à la broadcast
                            messages = messages
                                .where((message) =>
                                    message.broadcastId == broadcast.id)
                                .toList();
                            messages.sort((Message a, Message b) => b.sentAt.compareTo(a.sentAt));
                            return messages.length == 0
                                ? Center(
                                    child: Text(
                                        ArchSampleLocalizations.of(context)
                                            .noMessages))
                                : Expanded(
                              child: ListView.builder(
                                  itemCount: messages.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final message = messages[index];

                                    return MessageItem(
                                      message: message,
                                      onTap: () {

                                      },
                                      membersInteractor: widget.membersInteractor,
                                    );
                                  }),
                            );
                          },
                        )
                      ],
                    );
                }).toList()));
      },
    );
  }
}

class _Tab {
  const _Tab({this.text, this.key});
  final String text;
  final Key key;
}
