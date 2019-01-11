import 'package:ccis_app/helpers/dependency_injection.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/widgets/loading.dart';


class MemberList extends StatelessWidget {
  MemberList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingSpinner(key: ArchSampleKeys.todosLoading);
  }
}