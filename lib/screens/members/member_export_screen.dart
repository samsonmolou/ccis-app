import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository/ccis_repository.dart';
import 'package:ccis_app/ccis_app.dart';

class MembersExportScreen extends StatefulWidget {
  final UserRepository repository;

  MembersExportScreen({@required this.repository})
      : super(key: ArchSampleKeys.membersImportScreen);

  @override
  State<StatefulWidget> createState() {
    return MembersExportScreenState();
  }
}

class MembersExportScreenState extends State<MembersExportScreen> {
  UserBloc usersBloc;

  @override
  void initState() {
    super.initState();

    usersBloc = UserBloc(widget.repository);

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}