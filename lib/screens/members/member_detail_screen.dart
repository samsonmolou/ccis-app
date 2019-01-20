import 'package:ccis_app/screens/members/member_add_edit_screen.dart';
import 'package:ccis_app/widgets/shared/loading.dart';
import 'package:ccis_app/widgets/members/member_category.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_app/ccis_app.dart';
import 'package:flutter/services.dart';


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
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          key: _scaffoldKey,
          body: CustomScrollView(
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
                        'img/default-user-img.jpg',
                        package: 'ccis_assets',
                        fit: BoxFit.cover,
                        height: _appBarHeight,
                      ),
                      const DecoratedBox(decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, -1.1),
                            colors: <Color>[Color(0x60000000), Color(0x00000000)],
                          )
                      ))
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle.dark,
                    child: MemberCategory(
                      icon: Icons.phone,
                      children: <Widget>[
                        MemberItem(
                          lines: <String>[
                            member.phoneNumber,
                            ArchSampleLocalizations.of(context).newMemberPhoneNumberHint
                          ],
                        ),
                      ],
                    ),
                  ),
                  MemberCategory(
                    icon: Icons.home,
                    children: <Widget>[
                      MemberItem(
                        lines: <String>[
                          member.residence,
                          ArchSampleLocalizations.of(context).newMemberResidenceHint
                        ],
                      ),
                    ],
                  ),
                  MemberCategory(
                    icon: Icons.hotel,
                    children: <Widget>[
                      MemberItem(
                        lines: <String>[
                          member.bedroomNumber,
                          ArchSampleLocalizations.of(context).newMemberBedroomNumberHint
                        ],
                      ),
                    ],
                  ),
                  MemberCategory(
                    icon: Icons.people,
                    children: <Widget>[
                      MemberItem(
                        lines: <String>[
                          member.community,
                          ArchSampleLocalizations.of(context).newMemberCommunityHint
                        ],
                      ),
                    ],
                  ),
                  MemberCategory(
                    icon: Icons.school,
                    children: <Widget>[
                      MemberItem(
                        lines: <String>[
                          member.study,
                          ArchSampleLocalizations.of(context).newMemberStudyHint
                        ],
                      ),
                    ],
                  )
                ]),
              ),

            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: ArchSampleLocalizations.of(context).editMember,
            child: Icon(Icons.edit),
            key: ArchSampleKeys.editMemberFab,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MemberAddEditScreen(
                      member: member,
                      updateTodo: memberBloc.updateMember.add,
                      key: ArchSampleKeys.editMemberScreen,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}