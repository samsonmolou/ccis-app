import 'dart:async';

import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';
import 'package:ccis_app/widgets/broadcastList/member_item.dart';

class BroadcastListAddEditScreen extends StatefulWidget {
  final BroadcastList broadcastList;
  //TODO: remove this later, using context
  final BroadcastListInteractor broadcastListsInteractor;
  final Function(BroadcastList) addBroadcastList;
  final Function(BroadcastList) updateBroadcastList;
  final BroadcastListAddEditSearchBloc Function() initSearchBloc;

  BroadcastListAddEditScreen(
      {Key key,
      this.broadcastList,
      this.addBroadcastList,
      this.updateBroadcastList,
      @required this.broadcastListsInteractor,
      @required this.initSearchBloc})
      : super(key: key ?? ArchSampleKeys.addEditBroadcastListScreen);

  @override
  _BroadcastListAddEditScreen createState() => _BroadcastListAddEditScreen();
}

class _BroadcastListAddEditScreen extends State<BroadcastListAddEditScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BroadcastListAddEditSearchBloc memberSearchBloc;

  String _name;
  //List<BroadcastListMember> _selectedBroadcastListMembers;
  List<String> _selectedMembersId;

  final TextEditingController _searchBoxController =
      new TextEditingController();
  String query;

  @override
  void initState() {
    super.initState();
    memberSearchBloc = widget.initSearchBloc();
    query = "";
    memberSearchBloc.query.add(query);
    _selectedMembersId =
        isEditing ? widget.broadcastList.membersId : List<String>();
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
                  widget.updateBroadcastList(widget.broadcastList
                      .copyWith(name: _name, membersId: _selectedMembersId));
                } else {
                  widget.addBroadcastList(BroadcastList(
                      name: _name, membersId: _selectedMembersId));
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
                initialValue: widget.broadcastList != null
                    ? widget.broadcastList.name
                    : '',
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
                onSaved: (value) => _name = value,
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: new BoxDecoration(
                    border:
                        new Border.all(color: Theme.of(context).primaryColor)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      key: ArchSampleKeys.addEditSearchField,
                      controller: _searchBoxController,
                      onChanged: memberSearchBloc.query.add,
                      decoration: InputDecoration(
                        hintText:
                            ArchSampleLocalizations.of(context).searchMember,
                        filled: true,
                        hasFloatingPlaceholder: false,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: query != ""
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _searchBoxController.clear();
                                  memberSearchBloc.query.add('');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                      ),
                    ),
                    Divider(),
                    StreamBuilder<List<Member>>(
                      stream: memberSearchBloc.queryResult,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return LinearLoading();

                        List<Member> members = snapshot.data;

                        return members.length == 0
                            ? Center(
                                child: Text(ArchSampleLocalizations.of(context)
                                    .notFound))
                            : ListView.builder(
                                itemCount: members.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final member = members[index];
                                  return MemberItem(
                                      member: member,
                                      checkboxValue: _selectedMembersId
                                          .contains(member.id),
                                      onCheckboxChanged: (value) {
                                        setState(() {
                                          _selectedMembersId.contains(member.id)
                                              ? _selectedMembersId
                                                  .remove(member.id)
                                              : _selectedMembersId
                                                  .add(member.id);
                                        });
                                      });
                                },
                              );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool get isEditing => widget.broadcastList != null;
}
