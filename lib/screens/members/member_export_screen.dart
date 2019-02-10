import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/helpers/file_extension.dart';
import 'package:ccis_app/widgets/shared/loading_spinner.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MembersExportScreen extends StatefulWidget {
  final MembersImportBloc Function() initBloc;

  MembersExportScreen({Key key, this.initBloc})
      : super(key: key ?? ArchSampleKeys.membersExportScreen);

  @override
  State<StatefulWidget> createState() {
    return MembersExportScreenState();
  }
}

class MembersExportScreenState extends State<MembersExportScreen> {
  MembersImportBloc membersImportBloc;
  int _currentStep = 0;

  String _fileName = '...';
  String _filePath = '';

  @override
  void initState() {
    super.initState();

    membersImportBloc = widget.initBloc();
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

  Widget buildBody(BuildContext context) {
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
                          onPressed: _filePath.isNotEmpty
                              ? () {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(ArchSampleLocalizations.of(context).notImplemented)
                            ));
                            return;
                            /*
                              setState(() {
                                _currentStep = _currentStep + 1;
                              });
                              membersImportBloc.importMembers.add(_filePath); */

                          }
                              : null,
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
          subtitle: Text(ArchSampleLocalizations.of(context).processingImport),
          isActive: true,
          content: new StreamBuilder<List<Member>>(
              stream: membersImportBloc.importedMembers,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LoadingSpinner();
                List<Member> members = snapshot.data;

                return new Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      child: Text(
                          ArchSampleLocalizations.of(context).addToDatabase),
                      color: Theme.of(context).accentColor,
                    ),
                    /*
                    ListView.builder(
                        key: ArchSampleKeys.importedMembersList,
                        itemCount: members.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final member = members[index];
                          return MemberItem(
                            member: member,
                            onTap: () {},
                            onDismissed: (direction) {},
                          );
                        }), */

                  ],
                );
              }))
    ];

    return Padding(
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
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(ArchSampleLocalizations.of(context).importMembers),
        ),
        body: Builder(builder: buildBody)
    );
  }
}
