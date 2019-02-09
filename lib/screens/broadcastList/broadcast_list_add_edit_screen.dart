import 'dart:async';

import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

class BroadcastListAddEditScreen extends StatefulWidget {
  final BroadcastList broadcastList;
  final Function(BroadcastList) addBroadcastList;
  final Function(BroadcastList) updateBroadcastList;

  BroadcastListAddEditScreen({
    Key key,
    this.broadcastList,
    this.addBroadcastList,
    this.updateBroadcastList,
  }) : super(key: key ?? ArchSampleKeys.addEditBroadcastListScreen);

  @override
  _BroadcastListAddEditScreen createState() => _BroadcastListAddEditScreen();
}

class _BroadcastListAddEditScreen extends State<BroadcastListAddEditScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? ArchSampleLocalizations.of(context).editBroadcastList
              : ArchSampleLocalizations.of(context).addBroadcastList,
        ),
        actions: <Widget>[
          IconButton(
            key: isEditing
                ? ArchSampleKeys.saveNewBroadcastList
                : ArchSampleKeys.saveNewBroadcastList,
            icon: Icon(isEditing ? Icons.check : Icons.add),
            tooltip: isEditing
                ? ArchSampleLocalizations.of(context).saveChanges
                : ArchSampleLocalizations.of(context).addBroadcastList,
            onPressed: () {
              final form = formKey.currentState;
              if (form.validate()) {
                form.save();

                if (isEditing) {
                  widget.updateBroadcastList(widget.broadcastList.copyWith(
                      name: _name));
                } else {
                  widget.addBroadcastList(BroadcastList(
                    name: _name,
                  ));
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
                widget.broadcastList != null ? widget.broadcastList.name : '',
                key: ArchSampleKeys.firstNameField,
                autofocus: isEditing ? false : true,

                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context)
                      .newBroadcastListNameHint,
                  labelText: ArchSampleLocalizations.of(context)
                      .newBroadcastListNameLabel,
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context).emptyBroadcastListNameError
                    : null,
                onSaved: (value) => _name = value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isEditing => widget.broadcastList != null;
}
