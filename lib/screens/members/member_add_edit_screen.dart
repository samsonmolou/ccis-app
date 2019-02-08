import 'dart:async';

import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/widgets/shared/loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

class MemberAddEditScreen extends StatefulWidget {
  final Member member;
  final Function(Member) addMember;
  final Function(Member) updateTodo;
  final CommunitiesInteractor communitiesInteractor;
  final StudiesInteractor studiesInteractor;

  MemberAddEditScreen({
    Key key,
    this.member,
    this.addMember,
    this.updateTodo,
    this.communitiesInteractor,
    this.studiesInteractor
  }) : super(key: key ?? ArchSampleKeys.addMemberScreen);

  @override
  _MemberAddEditScreen createState() => _MemberAddEditScreen();
}

class _MemberAddEditScreen extends State<MemberAddEditScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CommunitiesListBloc communitiesListBloc;
  StudiesListBloc studiesListBloc;

  String _firstName;
  String _secondName;
  String _phoneNumber;
  String _residence;
  String _bedroomNumber;
  Community _community;
  Study _study;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    communitiesListBloc = CommunitiesListBloc(widget.communitiesInteractor);
    studiesListBloc = StudiesListBloc(widget.studiesInteractor);
    _community = widget.member != null ? widget.member.community : _community;
    _study = widget.member != null ? widget.member.study : _study;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? ArchSampleLocalizations.of(context).editMember
              : ArchSampleLocalizations.of(context).addMember,
        ),
        actions: <Widget>[
          IconButton(
            key: isEditing
              ? ArchSampleKeys.saveMemberFab
              : ArchSampleKeys.saveNewMember,
            icon: Icon(isEditing ? Icons.check : Icons.add),
            tooltip: isEditing
                ? ArchSampleLocalizations.of(context).saveChanges
                : ArchSampleLocalizations.of(context).addMember,
            onPressed: () {
              final form = formKey.currentState;
              if (form.validate()) {
                form.save();

                if (isEditing) {
                  widget.updateTodo(widget.member.copyWith(
                      firstName: _firstName,
                      secondName: _secondName,
                      phoneNumber: _phoneNumber,
                      residence: _residence,
                      bedroomNumber: _bedroomNumber,
                      community2: _community,
                      study2: _study));
                } else {
                  widget.addMember(Member(
                      firstName: _firstName,
                      secondName: _secondName,
                      phoneNumber: _phoneNumber,
                      residence: _residence,
                      bedroomNumber: _bedroomNumber,
                      community2: _community,
                      study2: _study,
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
                    widget.member != null ? widget.member.firstName : '',
                key: ArchSampleKeys.firstNameField,
                autofocus: isEditing ? false : true,

                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context)
                      .newMemberFirstNameHint,
                  labelText: ArchSampleLocalizations.of(context)
                      .newMemberFirstNameLabel,
                  icon: Icon(Icons.person),
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context).emptyMemberError
                    : null,
                onSaved: (value) => _firstName = value,
              ),
              TextFormField(
                initialValue:
                    widget.member != null ? widget.member.secondName : '',
                key: ArchSampleKeys.secondNameField,
                autofocus: isEditing ? false : true,

                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context)
                      .newMemberSecondNameHint,
                  labelText: ArchSampleLocalizations.of(context)
                      .newMemberSecondNameLabel,
                  icon: Icon(Icons.person),
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context).emptyMemberError
                    : null,
                onSaved: (value) => _secondName = value,
              ),
              TextFormField(
                initialValue:
                    widget.member != null ? widget.member.phoneNumber : '',
                key: ArchSampleKeys.phoneNumberField,
                autofocus: isEditing ? false : true,

                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context)
                      .newMemberPhoneNumberHint,
                  labelText: ArchSampleLocalizations.of(context)
                      .newMemberPhoneNumberLabel,
                  icon: Icon(Icons.phone),
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context).emptyMemberError
                    : null,
                onSaved: (value) => _phoneNumber = value,
              ),
              TextFormField(
                initialValue:
                    widget.member != null ? widget.member.residence : '',
                key: ArchSampleKeys.secondNameField,
                autofocus: isEditing ? false : true,
                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context)
                      .newMemberResidenceHint,
                  labelText: ArchSampleLocalizations.of(context)
                      .newMemberResidenceLabel,
                  icon: Icon(Icons.home),
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context).emptyMemberError
                    : null,
                onSaved: (value) => _residence = value,
              ),
              TextFormField(
                initialValue:
                    widget.member != null ? widget.member.bedroomNumber : '',
                key: ArchSampleKeys.bedroomNumberField,
                autofocus: isEditing ? false : true,
                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context)
                      .newMemberBedroomNumberHint,
                  labelText: ArchSampleLocalizations.of(context)
                      .newMemberBedroomNumberLabel,
                  icon: Icon(Icons.hotel),
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context).emptyMemberError
                    : null,
                onSaved: (value) => _bedroomNumber = value,
              ),
              StreamBuilder(
                stream: communitiesListBloc.communities,
                builder: (context, snapshot) => snapshot.hasData ? DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: ArchSampleLocalizations.of(context)
                        .newMemberCommunityHint,
                    labelText: ArchSampleLocalizations.of(context)
                        .newMemberCommunityLabel,
                    icon: Icon(Icons.people),
                  ),
                  validator: (val) => val == null
                      ? ArchSampleLocalizations.of(context).emptyMemberError
                      : null,
                  items: snapshot.data.map<DropdownMenuItem<Community>>((Community value) {
                    return DropdownMenuItem<Community>(
                        value: value,
                        child: Text(value.name)
                    );
                  }).toList(),
                  onChanged: (Community newValue) {
                    setState(() {
                      _community = newValue;
                    });
                  },
                  value: _community,
                  onSaved: (Community value) => _community = value,
                ) : LoadingSpinner(),
              ),
              StreamBuilder(
                stream: studiesListBloc.studies,
                builder: (context, snapshot) => snapshot.hasData ? DropdownButtonFormField(
                  key: ArchSampleKeys.studyField,
                  decoration: InputDecoration(
                    hintText: ArchSampleLocalizations.of(context)
                        .newMemberStudyHint,
                    labelText: ArchSampleLocalizations.of(context)
                        .newMemberStudyLabel,
                    icon: Icon(Icons.school),
                  ),
                  validator: (val) => val == null
                      ? ArchSampleLocalizations.of(context).emptyMemberError
                      : null,
                  items: snapshot.data.map<DropdownMenuItem<Study>>((Study value) {
                    return DropdownMenuItem<Study>(
                        value: value,
                        child: Text(value.name)
                    );
                  }).toList(),
                  onChanged: (Study newValue) {
                    setState(() {
                      _study = newValue;
                    });
                  },
                  value: _study,
                  onSaved: (Study value) => _study = value,
                ) : LoadingSpinner(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isEditing => widget.member != null;
}
