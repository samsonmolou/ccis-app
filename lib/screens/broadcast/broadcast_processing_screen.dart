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
    final simCardsBloc = SimCardsBlocProvider.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).broadcast),
        actions: [],

      ),
      bottomNavigationBar: new StreamBuilder<List<SimCard>>(
          stream: simCardsBloc.getSimCards,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(height: 2, width: 2, child: LinearLoading());

            // On recupère la liste des cartes sim disponibles sur le téléphone
            final simCards = snapshot.data;

            return new Card(
              shape: BeveledRectangleBorder(),
              margin: EdgeInsets.zero,

              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: simCards
                    .map((simCard) => Expanded(
                          child: RaisedButton(
                              elevation: 10.0,
                              onPressed: () {

                              },
                              color: Theme.of(context).primaryColor,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(height: 18.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.sim_card,
                                        size: 18.0,
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                          '${ArchSampleLocalizations.of(context).sim} ${simCard.slot.toString()}',
                                          semanticsLabel:
                                              '${ArchSampleLocalizations.of(context).sim} ${simCard.slot.toString()}'),
                                    ],
                                  ),
                                  SizedBox(height: 18.0),
                                ],
                              )),
                        ))
                    .toList(),
              ),
            );
          }),
      body: MessagesList(
        broadcast: widget.broadcast,
        messagesInteractor: widget.messagesInteractor,
      ),
    );
  }
}
