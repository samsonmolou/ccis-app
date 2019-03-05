import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/dependency_injector/member_injector.dart';
import 'package:ccis_app/screens/members/member_import_screen.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  final MembersInteractor membersInteractor;
  NavigationDrawer({Key key, @required this.membersInteractor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            height: 120.0,
            child: new DrawerHeader(
                padding: new EdgeInsets.all(0.0),
                decoration: new BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: new Center(
                  child: new FlutterLogo(
                    size: 54.0,
                  ),
                )),
          ),
          new ListTile(
            leading: new Icon(Icons.home),
            title: new Text(ArchSampleLocalizations.of(context).home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          new ExpansionTile(
            title: Text(ArchSampleLocalizations.of(context).members),
            leading: new Icon(Icons.people),

            children: <Widget>[
              ListTile(
                title: Text(ArchSampleLocalizations.of(context).exportMembers),
                onTap: () {
                  Navigator.pushNamed(context, ArchSampleRoutes.exportMembers);
                },
              ),
              ListTile(
                title: Text(ArchSampleLocalizations.of(context).importMembers),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return MembersImportScreen(
                            initBloc: () =>
                                MembersImportBloc(this.membersInteractor),
                          );
                        },
                      )
                  );
                  //Navigator.pushNamed(context, ArchSampleRoutes.importMembers);
                },
              )
            ],
          ),
          new Divider(),
          new ListTile(
              leading: new Icon(Icons.exit_to_app),
              title: new Text(ArchSampleLocalizations.of(context).exit),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
