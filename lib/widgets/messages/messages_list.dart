import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/broadcast_injector.dart';
import 'package:ccis_app/providers/broadcasts_bloc_provider.dart';
import 'package:ccis_app/screens/broadcast/broadcast_add_forward_screen.dart';
import 'package:ccis_app/screens/broadcast/broadcast_detail_screen.dart';
import 'package:ccis_app/widgets/broadcasts/broadcast_item.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

import 'message_item.dart';

class MessagesList extends StatefulWidget {
  final Broadcast broadcast;
  final MessagesInteractor messagesInteractor;
  final MembersInteractor membersInteractor;

  MessagesList(
      {Key key, @required this.broadcast, @required this.messagesInteractor, @required this.membersInteractor})
      : super(key: key);

  @override
  MessagesListState createState() {
    return MessagesListState();
  }
}

class MessagesListState extends State<MessagesList> {
  MessagesListBloc messagesListBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messagesListBloc = MessagesListBloc(widget.messagesInteractor);
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Message>>(
      stream: messagesListBloc.messages.map((messages) => messages.where((message) => message.broadcastId == widget.broadcast.id).toList()),
      builder: (context, snapshot) => snapshot.hasData
          ? _buildList(snapshot.data)
          : SpinnerLoading(key: ArchSampleKeys.messagesListsLoading),
    );
  }

  ListView _buildList(List<Message> messages) {
    messages.sort((Message a, Message b) => b.sentAt.compareTo(a.sentAt));
    return ListView.builder(
      key: ArchSampleKeys.broadcastLists,
      itemCount: messages.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final message = messages[index];

        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor))),
          child: MessageItem(
            message: message,
            membersInteractor:
              widget.membersInteractor,
            onTap: () {

            },
          ),
        );
      },
    );
  }

  void _removeBroadcastList(BuildContext context, Broadcast broadcast) {
    BroadcastsBlocProvider.of(context).deleteBroadcast.add(broadcast.id);

    _showUndoSnackbar(context, broadcast);
  }

  void _editMember(BuildContext context, Broadcast broadcast) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BroadcastAddForwardScreen(
            broadcast: broadcast,
            updateBroadcast:
                BroadcastsBlocProvider.of(context).updateBroadcast.add,
            broadcastInteractor:
                BroadcastInjector.of(context).broadcastsInteractor,
            messagesInteractor:
                BroadcastInjector.of(context).messagesInteractor,
            membersInteractor: BroadcastInjector.of(context).membersInteractor,
            rankInteractor: BroadcastInjector.of(context).rankInteractor,
            broadcastListInteractor:
                BroadcastInjector.of(context).broadcastListInteractor,
            key: ArchSampleKeys.editBroadcastScreen,
          );
        },
      ),
    );
  }

  void _showUndoSnackbar(BuildContext context, Broadcast broadcast) {
    final snackBar = SnackBar(
      key: ArchSampleKeys.snackbar,
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).backgroundColor,
      content: Text(
        ArchSampleLocalizations.of(context).memberDeleted(broadcast.message),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      action: SnackBarAction(
        key: ArchSampleKeys.snackbarAction(broadcast.id),
        label: ArchSampleLocalizations.of(context).cancel,
        onPressed: () {
          BroadcastsBlocProvider.of(context).addBroadcast.add(broadcast);
        },
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
