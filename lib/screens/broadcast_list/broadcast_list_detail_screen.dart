import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/broadcast_list/broadcast_list_add_edit_screen.dart';
import 'package:ccis_app/screens/members/member_detail_screen.dart';
import 'package:ccis_app/widgets/members/member_item.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BroadcastListDetailScreen extends StatefulWidget {
  final String broadcastListId;
  final BroadcastListBloc Function() initBloc;
  final MembersInteractor membersInteractor;
  final BroadcastListInteractor broadcastListInteractor;
  final BroadcastListAddEditSearchBloc Function() initSearchBloc;

  BroadcastListDetailScreen(
      {@required this.broadcastListId,
      @required this.initBloc,
      @required this.membersInteractor,
      @required this.broadcastListInteractor,
      @required this.initSearchBloc})
      : super(key: ArchSampleKeys.memberDetailsScreen);

  @override
  BroadcastListDetailScreenState createState() {
    return BroadcastListDetailScreenState();
  }
}

class BroadcastListDetailScreenState extends State<BroadcastListDetailScreen> {
  BroadcastListBloc broadcastListBloc;
  BroadcastListAddEditSearchBloc memberSearchBloc;
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  final TextEditingController _searchBoxController =
      new TextEditingController();
  String query;

  @override
  void initState() {
    super.initState();
    broadcastListBloc = widget.initBloc();
    memberSearchBloc = widget.initSearchBloc();
    query = "";
    memberSearchBloc.query.add(query);
  }

  @override
  void dispose() {
    broadcastListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BroadcastList>(
      stream: broadcastListBloc
          .broadcastList(widget.broadcastListId)
          .where((broadcastList) => broadcastList != null),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SpinnerLoading();

        final broadcastList = snapshot.data;

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(broadcastList.name),
            actions: [
              IconButton(
                key: ArchSampleKeys.deleteBroadcastListButton,
                tooltip:
                    ArchSampleLocalizations.of(context).deleteBroadcastList,
                icon: Icon(Icons.delete),
                onPressed: () {
                  broadcastListBloc.deleteBroadcastList.add(broadcastList.id);
                  Navigator.pop(context, broadcastList);
                },
              ),
              IconButton(
                key: ArchSampleKeys.editBroadcastListButton,
                tooltip: ArchSampleLocalizations.of(context).editMember,
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return BroadcastListAddEditScreen(
                          broadcastList: broadcastList,
                          broadcastListsInteractor:
                              widget.broadcastListInteractor,
                          updateBroadcastList:
                              broadcastListBloc.updateBroadcastList.add,
                          key: ArchSampleKeys.editBroadcastListScreen,
                          initSearchBloc: () => BroadcastListAddEditSearchBloc(
                              widget.membersInteractor,
                              widget.broadcastListInteractor),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  key: ArchSampleKeys.addEditSearchField,
                  controller: _searchBoxController,
                  onChanged: memberSearchBloc.query.add,
                  decoration: InputDecoration(
                    hintText: ArchSampleLocalizations.of(context).searchMember,
                    filled: true,
                    hasFloatingPlaceholder: false,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: query != ""
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _searchBoxController.clear();
                              memberSearchBloc.query.add('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                  ),
                ),
                Divider(),
                StreamBuilder<List<Member>>(
                  stream: memberSearchBloc.queryResult,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearLoading();

                    List<Member> members = snapshot.data;
                    // On filtre la liste pour retenir uniquement les membres appartenant à la broadcast list
                    members = members
                        .where((member) =>
                            broadcastList.membersId.contains(member.id))
                        .toList();

                    return members.length == 0
                        ? Center(
                            child: Text(
                                ArchSampleLocalizations.of(context).noMembers))
                        : ListView.builder(
                            itemCount: members.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              final member = members[index];

                              return MemberItem(
                                member: member,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return MemberDetailScreen(
                                          memberId: member.id,
                                          initBloc: () => MemberBloc(
                                              widget.membersInteractor),
                                        );
                                      },
                                    ),
                                  );
                                },
                                onDismissed: null,
                              );
                            },
                          );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
