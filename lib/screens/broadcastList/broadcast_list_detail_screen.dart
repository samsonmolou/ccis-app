import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/broadcastList/broadcast_list_add_edit_screen.dart';
import 'package:ccis_app/widgets/members/member_category.dart';
import 'package:ccis_app/widgets/shared/loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class BroadcastListDetailScreen extends StatefulWidget {
  final String broadcastListId;
  final BroadcastListBloc Function() initBloc;

  BroadcastListDetailScreen({
    @required this.broadcastListId,
    @required this.initBloc,
  }) : super(key: ArchSampleKeys.memberDetailsScreen);

  @override
  BroadcastListDetailScreenState createState() {
    return BroadcastListDetailScreenState();
  }
}

class BroadcastListDetailScreenState extends State<BroadcastListDetailScreen> {
  BroadcastListBloc broadcastListBloc;
  final double _appBarHeight = 256.0;
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    broadcastListBloc = widget.initBloc();
  }

  @override
  void dispose() {
    broadcastListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BroadcastList>(
      stream: broadcastListBloc.broadcastList(widget.broadcastListId).where((broadcastList) => broadcastList != null),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingSpinner();

        final broadcastList = snapshot.data;

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(broadcastList.name),
            actions: [
              IconButton(
                key: ArchSampleKeys.deleteBroadcastListButton,
                tooltip: ArchSampleLocalizations.of(context).deleteMember,
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
                          updateBroadcastList: broadcastListBloc.updateBroadcastList.add,
                          key: ArchSampleKeys.editBroadcastListScreen,
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
          ),
        );
      },
    );
  }
}