import 'dart:async';

import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/ccis_app.dart';

class MemberAddEditScreen extends StatefulWidget {
  final Member member;
  final Function(Member) addMember;
  final Function(Member) updateTodo;

  MemberAddEditScreen({Key key, this.member, this.addMember, this.updateTodo})
      : super(key: key ?? ArchSampleKeys.addMemberScreen);

  @override
  _MemberAddEditScreen createState() => _MemberAddEditScreen();
}

class _MemberAddEditScreen extends State<MemberAddEditScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _firstName;
  String _secondName;
  String _phoneNumber;
  String _residence;
  String _bedroomNumber;
  String _community;
  String _study;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? ArchSampleLocalizations.of(context).editMember
              : ArchSampleLocalizations.of(context).addMember,
        ),
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
                style: Theme.of(context).textTheme.headline,
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
                style: Theme.of(context).textTheme.headline,
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
                style: Theme.of(context).textTheme.headline,
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
                style: Theme.of(context).textTheme.headline,
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
                style: Theme.of(context).textTheme.headline,
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
              TextFormField(
                initialValue:
                    widget.member != null ? widget.member.community : '',
                key: ArchSampleKeys.communityField,
                autofocus: isEditing ? false : true,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context)
                      .newMemberCommunityHint,
                  labelText: ArchSampleLocalizations.of(context)
                      .newMemberCommunityLabel,
                  icon: Icon(Icons.people),
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context).emptyMemberError
                    : null,
                onSaved: (value) => _community = value,
              ),
              TextFormField(
                initialValue: widget.member != null ? widget.member.study : '',
                key: ArchSampleKeys.studyField,
                autofocus: isEditing ? false : true,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText:
                      ArchSampleLocalizations.of(context).newMemberStudyHint,
                  labelText:
                      ArchSampleLocalizations.of(context).newMemberStudyLabel,
                  icon: Icon(Icons.school),
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context).emptyMemberError
                    : null,
                onSaved: (value) => _study = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing
            ? ArchSampleKeys.saveMemberFab
            : ArchSampleKeys.saveNewMember,
        tooltip: isEditing
            ? ArchSampleLocalizations.of(context).saveChanges
            : ArchSampleLocalizations.of(context).addMember,
        child: Icon(isEditing ? Icons.check : Icons.add),
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
                  community: _community,
                  study: _study));
            } else {
              widget.addMember(Member(
                  firstName: _firstName,
                  secondName: _secondName,
                  phoneNumber: _phoneNumber,
                  residence: _residence,
                  bedroomNumber: _bedroomNumber,
                  community: _community,
                  study: _study));
            }
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  bool get isEditing => widget.member != null;
}
