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
  final double _appBarHeight = 256.0;


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

        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: true,
              actions: <Widget>[
                IconButton(
                  key: ArchSampleKeys.deleteMemberButton,
                  tooltip: ArchSampleLocalizations.of(context).deleteMember,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    memberBloc.deleteMember.add(member.id);
                    Navigator.pop(context, member);
                  },
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(member.firstName + ' ' + member.secondName),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'img/img_member_128.png',
                      package: 'ccis_assets',
                      fit: BoxFit.cover,
                      height: 1,
                      width: 1,
                      scale: 1,
                    ),
                    const DecoratedBox(decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, -0.4),
                          colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      )
                    ))
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}