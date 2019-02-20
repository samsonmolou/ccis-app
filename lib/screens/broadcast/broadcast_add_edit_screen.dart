import 'dart:async';

import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class BroadcastAddEditScreen extends StatefulWidget {
  final Broadcast broadcast;
  //TODO: remove this later, using context
  final BroadcastInteractor broadcastsInteractor;
  final Function(Broadcast) addBroadcast;
  final Function(Broadcast) updateBroadcast;

  BroadcastAddEditScreen({
    Key key,
    this.broadcast,
    this.addBroadcast,
    this.updateBroadcast,
    @required this.broadcastsInteractor,
  }) : super(key: key ?? ArchSampleKeys.addEditBroadcastScreen);

  @override
  _BroadcastAddEditScreen createState() => _BroadcastAddEditScreen();
}

class _BroadcastAddEditScreen extends State<BroadcastAddEditScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _message;
  String _broadcastListId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? ArchSampleLocalizations.of(context).editBroadcastList
              : ArchSampleLocalizations.of(context).newBroadcastList,
        ),
        actions: <Widget>[
          IconButton(
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
                      dateHeure: formatDate(DateTime.now(),
                          [d, '-', M, '-', yyyy, ' ', HH, ':', nn, ':', ss])));
                } else {
                  widget.addBroadcast(Broadcast(
                      message: _message,
                      broadcastListId: _broadcastListId,
                      dateHeure: formatDate(DateTime.now(),
                          [d, '-', M, '-', yyyy, ' ', HH, ':', nn, ':', ss])));
                }
                Navigator.pop(context);
              }
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
                    widget.broadcast != null ? widget.broadcast.message : '',
                key: ArchSampleKeys.broadcastListNameField,
                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context)
                      .newBroadcastListNameHint,
                  labelText: ArchSampleLocalizations.of(context)
                      .newBroadcastListNameLabel,
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context)
                        .emptyBroadcastListNameError
                    : null,
                onSaved: (value) => _message = value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isEditing => widget.broadcast != null;
}
