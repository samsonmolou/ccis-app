import 'dart:async';

import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_app/widgets/messages/waiting_message_item.dart';
import 'package:ccis_app/providers/sim_cards_bloc_provider.dart';
import 'package:ccis_app/widgets/messages/messages_list.dart';
import 'package:ccis_app/widgets/broadcasts/sim_card_dialog.dart';
import 'package:sms/sms.dart';

import 'broadcast_processing_screen.dart';

class BroadcastAddForwardScreen extends StatefulWidget {
  final Broadcast broadcast;
  //TODO: remove this later, using context
  final BroadcastInteractor broadcastInteractor;
  final BroadcastListInteractor broadcastListInteractor;
  final MembersInteractor membersInteractor;
  //TODO: Make rankInteractor optional
  final RankInteractor rankInteractor;
  final MessagesInteractor messagesInteractor;
  final Function(Broadcast) addBroadcast;
  final Function(Broadcast) updateBroadcast;

  BroadcastAddForwardScreen(
      {Key key,
      this.broadcast,
      this.addBroadcast,
      this.updateBroadcast,
      @required this.broadcastInteractor,
      @required this.rankInteractor,
      @required this.broadcastListInteractor,
      @required this.messagesInteractor,
      @required this.membersInteractor})
      : super(key: key ?? ArchSampleKeys.addEditBroadcastScreen);

  @override
  _BroadcastAddForwardScreen createState() => _BroadcastAddForwardScreen();
}

class _BroadcastAddForwardScreen extends State<BroadcastAddForwardScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RankBloc rankBloc;
  BroadcastListBloc broadcastListBloc;
  BroadcastListListBloc broadcastListListBloc;
  MessagesListBloc messagesListBloc;
  MessagesBroadcastingBloc messagesBroadcastingBloc;
  MembersListBloc memberListBloc;
  SimCardsBloc simCardsBloc;

  String _message; // Le message a envoyé
  String _broadcastListId; // L'identifiant de la liste de diffusion
  String _name; // Le nom de la diffusion
  BroadcastList _broadcastList; // Pour le choix de la liste de diffusion
  int _currentStep = 0; // Step pour le Stepper
  Broadcast _broadcast; // Représente la diffusion nouvellement crée
  List<Member> _members; // Les membres de la broadcast list
  Rank _rank; // Numero de sequence de la diffusion
  List<Message> _waitingMessages;

  @override
  void initState() {
    super.initState();
    rankBloc = RankBloc(widget.rankInteractor);
    broadcastListListBloc =
        BroadcastListListBloc(widget.broadcastListInteractor);
    broadcastListBloc = BroadcastListBloc(widget.broadcastListInteractor);
    messagesListBloc = MessagesListBloc(widget.messagesInteractor);
    memberListBloc = MembersListBloc(widget.membersInteractor);
    messagesBroadcastingBloc =
        MessagesBroadcastingBloc(widget.messagesInteractor);
    if (isForwarding) {
      // On recupère le broadcast list associé a l'identifiant de la broadcast
      broadcastListBloc
          .broadcastList(widget.broadcast.broadcastListId)
          .first
          .then((value) {
        _broadcastList = value;
        _broadcastListId = value.id;
      });
    }
    simCardsBloc = SimCardsBloc(SimCardsInteractor());
    simCardsBloc.loadSimCards();
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      new Step(
          title: Text(ArchSampleLocalizations.of(context).stepOne),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue:
                      widget.broadcast != null ? widget.broadcast.name : _name,
                  key: ArchSampleKeys.broadcastNameField,
                  decoration: InputDecoration(
                    hintText: ArchSampleLocalizations.of(context)
                        .newBroadcastNameHint,
                    labelText: ArchSampleLocalizations.of(context)
                        .newBroadcastNameLabel,
                  ),
                  validator: (val) => val.trim().isEmpty
                      ? ArchSampleLocalizations.of(context)
                          .emptyBroadcastNameError
                      : null,
                  onSaved: (value) => _name = value,
                ),
                StreamBuilder(
                  stream: broadcastListListBloc.broadcastLists,
                  builder: (context, snapshot) => snapshot.hasData
                      ? DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: ArchSampleLocalizations.of(context)
                                .selectBroadcastListHint,
                            labelText: ArchSampleLocalizations.of(context)
                                .selectBroadcastListLabel,
                          ),
                          validator: (val) => val == null
                              ? ArchSampleLocalizations.of(context)
                                  .emptySelectedBroadcastListError
                              : null,
                          items: snapshot.data
                              .map<DropdownMenuItem<BroadcastList>>(
                                  (BroadcastList value) {
                            return DropdownMenuItem<BroadcastList>(
                                value: value, child: Text(value.name));
                          }).toList(),
                          onChanged: (BroadcastList newValue) {
                            setState(() {
                              _broadcastList = newValue;
                              _broadcastListId = newValue.id;
                            });
                          },
                          value: _broadcastList,
                          onSaved: (BroadcastList value) {
                            _broadcastList = value;
                            _broadcastListId = value.id;
                          },
                        )
                      : LinearLoading(),
                ),
                TextFormField(
                  initialValue: widget.broadcast != null
                      ? widget.broadcast.message
                      : _message,
                  key: ArchSampleKeys.broadcastMessageField,
                  decoration: InputDecoration(
                    helperText: ArchSampleLocalizations.of(context)
                        .newBroadcastMessageHelp,
                    hintText: ArchSampleLocalizations.of(context)
                        .newBroadcastMessageHint,
                    labelText: ArchSampleLocalizations.of(context)
                        .newBroadcastMessageLabel,
                  ),
                  validator: (val) => val.trim().isEmpty
                      ? ArchSampleLocalizations.of(context)
                          .emptyBroadcastMessageError
                      : null,
                  onSaved: (value) => _message = value,
                  maxLines: 8,
                ),
              ],
            ),
          ),
          subtitle: Text(ArchSampleLocalizations.of(context).editingMessage),
          isActive: _currentStep == 0 ? true : false),
      new Step(
        title: Text(ArchSampleLocalizations.of(context).stepTwo),
        subtitle: Text(ArchSampleLocalizations.of(context).check),
        isActive: _currentStep == 1 ? true : false,
        content: _currentStep == 1
            ? StreamBuilder<List<Message>>(
                stream: messagesBroadcastingBloc.waitingMessages(
                    this._broadcast, this._members),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return SpinnerLoading();

                  this._waitingMessages = snapshot.data;

                  return Column(
                      children: _waitingMessages
                          .map((message) => WaitingMessageItem(
                                onTap: () => {},
                                message: message,
                                membersInteractor: widget.membersInteractor,
                              ))
                          .toList());
                })
            : SpinnerLoading(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isForwarding
              ? ArchSampleLocalizations.of(context).newBroadcast
              : ArchSampleLocalizations.of(context).newBroadcast,
        ),
        actions: <Widget>[
          StreamBuilder<Rank>(
            stream: rankBloc.getRank,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return SpinnerLoading();
              _rank = snapshot.data;
              return IconButton(
                key: isForwarding
                    ? ArchSampleKeys.saveNewBroadcastList
                    : ArchSampleKeys.saveNewBroadcastList,
                icon: Icon(isForwarding ? Icons.check : Icons.add),
                tooltip: isForwarding
                    ? ArchSampleLocalizations.of(context).saveChanges
                    : ArchSampleLocalizations.of(context).newBroadcastList,
                onPressed: () {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    form.save();

                    if (isForwarding) {
                      widget.updateBroadcast(widget.broadcast.copyWith(
                          message: _message,
                          broadcastListId: _broadcastListId,
                          name: _name,
                          dateTime: DateTime.now().toString()));
                    } else {
                      widget.addBroadcast(Broadcast(
                          message: _message,
                          rank: _rank.value,
                          broadcastListId: _broadcastListId,
                          name: _name,
                          dateTime: DateTime.now().toString()));

                      rankBloc.updateRank.add(_rank);
                    }
                    Navigator.pop(context);
                  }
                },
              );
            },
          )
        ],
      ),
      bottomNavigationBar: Card(
          margin: EdgeInsets.zero,
          shape: BeveledRectangleBorder(),
          color: Theme.of(context).bottomAppBarColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 3.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _currentStep != 0
                      ? FlatButton(
                          onPressed: () {
                            setState(() {
                              if (_currentStep >= 0)
                                _currentStep = _currentStep - 1;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.navigate_before,
                                size: 18.0,
                              ),
                              SizedBox(
                                width: 3.0,
                              ),
                              Text(ArchSampleLocalizations.of(context).back,
                                  semanticsLabel:
                                      ArchSampleLocalizations.of(context).back),
                            ],
                          ),
                        )
                      : Container(),
                  StreamBuilder<List<SimCard>>(
                    stream: simCardsBloc.getSimCards,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                            height: 2, width: 2, child: LinearLoading());

                      final simCards = snapshot.data;

                      return FlatButton(
                        onPressed: () {
                          final form = formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            setState(() {
                              _broadcast = Broadcast(
                                      message: _message,
                                      rank: _rank.value,
                                      broadcastListId: _broadcastListId,
                                      name: _name,
                                      dateTime: DateTime.now().toString());
                              // On recupère les membres de la broadcast list selectionné par l'utilisateur
                              memberListBloc.members.listen((members) =>
                                  _members = members
                                      .where((member) => _broadcastList
                                          .membersId
                                          .contains(member.id))
                                      .toList());
                              if (_currentStep < 1)
                                _currentStep = _currentStep + 1;
                              else {

                                  widget.addBroadcast(_broadcast);
                                  rankBloc.updateRank.add(_rank);


                                showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                          title: Text(
                                              ArchSampleLocalizations.of(
                                                      context)
                                                  .selectSimCard),
                                          children: simCards
                                              .map((simCard) =>
                                                  SimCardDialogItem(
                                                    icon: Icons.sim_card,
                                                    text:
                                                        '${ArchSampleLocalizations.of(context).sim} ${simCard.slot.toString()}',
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, simCard);
                                                    },
                                                  ))
                                              .toList(),
                                        )).then<void>((simCard) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return new BroadcastProcessingScreen(
                                          broadcast: this._broadcast,
                                          messages: this._waitingMessages,
                                          simCard: simCard,
                                          broadcastInteractor:
                                              widget.broadcastInteractor,
                                          rankInteractor: widget.rankInteractor,
                                          messagesInteractor:
                                              widget.messagesInteractor,
                                          broadcastListInteractor:
                                              widget.broadcastListInteractor,
                                          membersInteractor:
                                              widget.membersInteractor,
                                          addMessages: messagesBroadcastingBloc
                                              .addMessages.add,
                                          initBloc: () => BroadcastBloc(
                                              widget.broadcastInteractor),
                                        );
                                      },
                                    ),
                                  );
                                });
                              }
                            });
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            this._currentStep == 0
                                ? Text(ArchSampleLocalizations.of(context).next,
                                    semanticsLabel:
                                        ArchSampleLocalizations.of(context)
                                            .next)
                                : Text(
                                    ArchSampleLocalizations.of(context)
                                        .startBroadcast,
                                    semanticsLabel:
                                        ArchSampleLocalizations.of(context)
                                            .startBroadcast),
                            SizedBox(
                              width: 3.0,
                            ),
                            this._currentStep == 0
                                ? Icon(
                                    Icons.navigate_next,
                                    size: 18.0,
                                  )
                                : Icon(
                                    Icons.playlist_play,
                                    size: 18.0,
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 4.0)
            ],
          )),
      body: Form(
          key: formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
          child: Stepper(
            steps: steps,
            currentStep: this._currentStep,
            type: StepperType.horizontal,
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Container(
                height: 0,
                width: 0,
              );
            },
          )),
    );
  }

  bool get isForwarding => widget.broadcast != null;
}
