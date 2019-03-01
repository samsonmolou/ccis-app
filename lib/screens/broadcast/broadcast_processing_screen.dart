import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/broadcast/broadcast_add_edit_screen.dart';
import 'package:ccis_app/widgets/broadcasts/broadcast_item.dart';
import 'package:ccis_app/widgets/messages/messages_list.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/providers/sim_cards_bloc_provider.dart';
import 'package:sms/sms.dart';

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
    final simCardsBloc = SimCardsBloc(SimCardsInteractor());
    simCardsBloc.loadSimCards();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).broadcast),
        actions: [],
      ),
      bottomNavigationBar: IconButton(
          icon: new StreamBuilder<SimCard>(
              stream: simCardsBloc.onSimCardChanged,
              initialData: simCardsBloc.selectedSimCard,
              builder: (context, snapshot) {
                final simCard = snapshot.data;

                return new Row(
                  children: [
                    new Icon(Icons.sim_card,
                        color: simCard.state == SimCardState.Ready
                            ? Colors.blue
                            : Colors.grey),
                    new Text(
                      snapshot.data.slot.toString(),
                      style: new TextStyle(
                          color: simCard.state == SimCardState.Ready
                              ? Colors.white
                              : Colors.grey),
                    ),
                  ],
                );
              }),
          onPressed: () {
            simCardsBloc.toggleSelectedSim();
          }),
      body: MessagesList(
        broadcast: widget.broadcast,
        messagesInteractor: widget.messagesInteractor,
      ),
    );
  }
}
