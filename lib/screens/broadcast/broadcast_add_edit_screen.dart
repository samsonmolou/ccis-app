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

  @override
  void initState() {
    super.initState();
    rankBloc = RankBloc(widget.rankInteractor);
    broadcastListListBloc =
        BroadcastListListBloc(widget.broadcastListInteractor);
    broadcastListBloc = BroadcastListBloc(widget.broadcastListInteractor);
    if (isEditing) {
      broadcastListBloc.broadcastList(widget.broadcast.broadcastListId).first.then(
          (value) {
            _broadcastList = value;
            _broadcastListId = value.id;
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
              TextFormField(
                initialValue:
                widget.broadcast != null ? widget.broadcast.name : '',
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

            ],
          ),
        ),
      ),
    );
  }

  bool get isEditing => widget.broadcast != null;
}
