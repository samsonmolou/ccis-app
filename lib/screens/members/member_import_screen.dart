import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/providers/members_import_bloc_provider.dart';
import 'package:ccis_app/helpers/file_extension.dart';
import 'package:flutter/services.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';


class MembersImportScreen extends StatefulWidget {
  final Function(String) importMembers;

  MembersImportScreen({Key key, this.importMembers})
      : super(key: key ?? ArchSampleKeys.membersImportScreen);

  @override
  State<StatefulWidget> createState() {
    return MembersImportScreenState();
  }
}

class MembersImportScreenState extends State<MembersImportScreen> {

  int _currentStep = 0;

  String _fileName = '...';
  String _filePath = '...';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _openFileExplorer({FileType pickingType, String fileExtension}) async {
    try {
      _filePath = await FilePicker.getFilePath(
          type: pickingType, fileExtension: fileExtension);
    } on PlatformException catch (e) {
      print("Unsupported operation " + e.toString());
    }

    if (!mounted) return;

    setState(() {
      _fileName = _filePath != null ? _filePath.split('/').last : '...';
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Step> memberImportSteps = [
      new Step(
          title: Text(ArchSampleLocalizations.of(context).stepOne),
          content: new Center(
              child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: new RaisedButton(
                  child:
                      new Text(ArchSampleLocalizations.of(context).chooseFile),
                  onPressed: () {
                    _openFileExplorer(
                        pickingType: FileType.CUSTOM,
                        fileExtension: FileExtension.csv);
                  },
                  color: Theme.of(context).buttonColor,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new Text(
                  ArchSampleLocalizations.of(context).fileName,
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Text(
                _fileName,
                textAlign: TextAlign.center,
              ),
              new Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () {},
                      child:
                          new Text(ArchSampleLocalizations.of(context).cancel),
                    ),
                    new RaisedButton(
                      onPressed: () {
                        setState(() {
                          _currentStep = _currentStep + 1;
                        });
                        widget.importMembers(_filePath);
                      },
                      child: new Text(ArchSampleLocalizations.of(context)
                          .startMemberImport),
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              )
            ],
          )),
          subtitle:
              Text(ArchSampleLocalizations.of(context).chooseFileToImport),
          isActive: true),
      new Step(
          title: Text(ArchSampleLocalizations.of(context).stepTwo),
          content: new Column()
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).importMembers),
      ),
      body: Padding(
        padding: EdgeInsets.all(1.0),
        child: new Container(
          child: new Stepper(
            // Using variable here for handling the currentStep
            currentStep: this._currentStep,
            //List of step
            steps: memberImportSteps,
            type: StepperType.horizontal,
            onStepTapped: (step) {},
            onStepContinue: () {},
            onStepCancel: () {},
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: new Row(),
              );
            },
          ),
        ),
      ),
    );
  }
}
