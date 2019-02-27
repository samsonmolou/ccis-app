import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/broadcast/broadcast_add_edit_screen.dart';
import 'package:ccis_app/widgets/broadcasts/broadcast_item.dart';
import 'package:ccis_app/widgets/messages/messages_list.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BroadcastProcessingScreen extends StatefulWidget {
  final Broadcast broadcast;
  final List<Message> messages;
  final BroadcastBloc Function() initBloc;
  final Function(List<Message>) addMessages;
  final BroadcastInteractor broadcastInteractor;
  final RankInteractor rankInteractor;
  final BroadcastListInteractor broadcastListInteractor;
  final MessagesInteractor messagesInteractor;
  final MembersInteractor membersInteractor;

  BroadcastProcessingScreen(
      {@required this.broadcast,
      @required this.messages,
      @required this.initBloc,
      @required this.broadcastInteractor,
      @required this.rankInteractor,
      @required this.broadcastListInteractor,
      @required this.messagesInteractor,
      @required this.membersInteractor,
      @required this.addMessages})
      : super(key: ArchSampleKeys.broadcastProcessingScreen);

  @override
  BroadcastProcessingScreenState createState() {
    return BroadcastProcessingScreenState();
  }
}

class BroadcastProcessingScreenState extends State<BroadcastProcessingScreen> {
  BroadcastBloc broadcastBloc;

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    broadcastBloc = widget.initBloc();
    widget.addMessages(widget.messages);
  }

  @override
  void dispose() {
    broadcastBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).broadcast),
        actions: [],
      ),
      bottomNavigationBar: RaisedButton(
          padding: EdgeInsets.zero,
          shape: BeveledRectangleBorder(),
          color: Theme.of(context).accentColor,
          onPressed: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 18.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.stop,
                    size: 18.0,
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Text(ArchSampleLocalizations.of(context).stopBroadcast,
                      semanticsLabel:
                          ArchSampleLocalizations.of(context).stopBroadcast),
                ],
              ),
              SizedBox(height: 18.0),
            ],
          )),
      body: MessagesList(
        broadcast: widget.broadcast,
        messagesInteractor: widget.messagesInteractor,
      ),
    );
  }
}
