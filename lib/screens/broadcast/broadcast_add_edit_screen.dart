import 'dart:async';

import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';

class BroadcastAddEditScreen extends StatefulWidget {
  final Broadcast broadcast;
  //TODO: remove this later, using context
  final BroadcastInteractor broadcastInteractor;
  final BroadcastListInteractor broadcastListInteractor;
  //TODO: Make rankInteractor optional using editing state
  final RankInteractor rankInteractor;
  final Function(Broadcast) addBroadcast;
  final Function(Broadcast) updateBroadcast;

  BroadcastAddEditScreen(
      {Key key,
      this.broadcast,
      this.addBroadcast,
      this.updateBroadcast,
      @required this.broadcastInteractor,
      @required this.rankInteractor,
      @required this.broadcastListInteractor})
      : super(key: key ?? ArchSampleKeys.addEditBroadcastScreen);

  @override
  _BroadcastAddEditScreen createState() => _BroadcastAddEditScreen();
}

class _BroadcastAddEditScreen extends State<BroadcastAddEditScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RankBloc rankBloc;
  BroadcastListBloc broadcastListBloc;
  BroadcastListListBloc broadcastListListBloc;
  String _message;
  String _broadcastListId;
  String _name;
  BroadcastList _broadcastList;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    rankBloc = RankBloc(widget.rankInteractor);
    broadcastListListBloc =
        BroadcastListListBloc(widget.broadcastListInteractor);
    broadcastListBloc = BroadcastListBloc(widget.broadcastListInteractor);
    if (isEditing) {
      broadcastListBloc
          .broadcastList(widget.broadcast.broadcastListId)
          .first
          .then((value) {
        _broadcastList = value;
        _broadcastListId = value.id;
      });
    }
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
                  widget.broadcast != null ? widget.broadcast.name : '',
                  key: ArchSampleKeys.broadcastNameField,
                  decoration: InputDecoration(
                    hintText:
                    ArchSampleLocalizations.of(context).newBroadcastNameHint,
                    labelText:
                    ArchSampleLocalizations.of(context).newBroadcastNameLabel,
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
                  initialValue:
                  widget.broadcast != null ? widget.broadcast.message : '',
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
          subtitle:
              Text(ArchSampleLocalizations.of(context).editingMessage),
          isActive: true),
      new Step(
          title: Text(ArchSampleLocalizations.of(context).stepTwo),
          subtitle: Text(ArchSampleLocalizations.of(context).check),
          isActive: true,
          content: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0.0),
                child: Text("Hello"),
              ),
              Container(
                padding: EdgeInsets.all(0.0),
                alignment: FractionalOffset.bottomCenter,
                child: Text("Hello"),
              )
            ],
          ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? ArchSampleLocalizations.of(context).editBroadcast
              : ArchSampleLocalizations.of(context).newBroadcast,
        ),
        actions: <Widget>[
          StreamBuilder<Rank>(
            stream: rankBloc.getRank,
            builder: (context, snapshot) {
              final rank = snapshot.data;
              return IconButton(
                key: isEditing
                    ? ArchSampleKeys.saveNewBroadcastList
                    : ArchSampleKeys.saveNewBroadcastList,
                icon: Icon(isEditing ? Icons.check : Icons.add),
                tooltip: isEditing
                    ? ArchSampleLocalizations.of(context).saveChanges
                    : ArchSampleLocalizations.of(context).newBroadcastList,
                onPressed: () {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    form.save();

                    if (isEditing) {
                      widget.updateBroadcast(widget.broadcast.copyWith(
                          message: _message,
                          broadcastListId: _broadcastListId,
                          name: _name,
                          dateTime: DateTime.now().toString()));
                    } else {
                      widget.addBroadcast(Broadcast(
                          message: _message,
                          rank: rank.value,
                          broadcastListId: _broadcastListId,
                          name: _name,
                          dateTime: DateTime.now().toString()));

                      rankBloc.updateRank.add(rank);
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
                _currentStep != 0 ? FlatButton(
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form.validate()) {
                      setState(() {
                        _currentStep = _currentStep - 1;
                      });
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          ArchSampleLocalizations.of(context).back,
                          semanticsLabel:
                          ArchSampleLocalizations.of(context).back),
                    ],
                  ),
                ) : Container(),
                FlatButton(
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form.validate()) {
                      setState(() {
                        if (_currentStep < 1)
                          _currentStep = _currentStep + 1;
                      });
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          ArchSampleLocalizations.of(context).next,
                          semanticsLabel:
                          ArchSampleLocalizations.of(context).next),
                      Icon(
                        Icons.navigate_next,
                        size: 18.0,
                      ),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: 4.0)
          ],
        )
      ),
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
              return Container();
            },
          )
      ),
    );
  }

  bool get isEditing => widget.broadcast != null;
}
