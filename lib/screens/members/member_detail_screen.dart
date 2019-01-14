import 'package:ccis_app/screens/members/member_add_edit_screen.dart';
import 'package:ccis_app/widgets/shared/loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/ccis_app.dart';

class MemberDetailScreen extends StatefulWidget {
  final String memberId;
  final MemberBloc Function() initBloc;

  MemberDetailScreen({
    @required this.memberId,
    @required this.initBloc,
  }) : super(key: ArchSampleKeys.memberDetailsScreen);

  @override
  MemberDetailScreenState createState() {
    return MemberDetailScreenState();
  }
}

class MemberDetailScreenState extends State<MemberDetailScreen> {
  MemberBloc memberBloc;

  @override
  void initState() {
    super.initState();
    memberBloc = widget.initBloc();
  }

  @override
  void dispose() {
    memberBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Member>(
      stream: memberBloc.member(widget.memberId).where((member) => member != null),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingSpinner();

        final member = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text(ArchSampleLocalizations.of(context).memberDetails),
          ),
        );
      },
    );
  }
}