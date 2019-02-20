import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/screens/broadcast/broadcast_add_edit_screen.dart';
import 'package:ccis_app/screens/broadcast/broadcast_detail_screen.dart';
import 'package:ccis_app/widgets/broadcast/broadcast_item.dart';
import 'package:ccis_app/widgets/shared/linear_loading.dart';
import 'package:ccis_app/widgets/shared/spinner_loading.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BroadcastDetailScreen extends StatefulWidget {
  final String broadcastId;
  final BroadcastBloc Function() initBloc;
  final BroadcastInteractor broadcastInteractor;
  final RankInteractor rankInteractor;

  BroadcastDetailScreen(
      {@required this.broadcastId,
      @required this.initBloc,
      @required this.broadcastInteractor,
      @required this.rankInteractor})
      : super(key: ArchSampleKeys.broadcastDetailsScreen);

  @override
  BroadcastDetailScreenState createState() {
    return BroadcastDetailScreenState();
  }
}

class BroadcastDetailScreenState extends State<BroadcastDetailScreen> {
  BroadcastBloc broadcastBloc;

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    broadcastBloc = widget.initBloc();
  }

  @override
  void dispose() {
    broadcastBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Broadcast>(
      stream: broadcastBloc
          .broadcast(widget.broadcastId)
          .where((broadcast) => broadcast != null),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SpinnerLoading();

        final broadcast = snapshot.data;

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(broadcast.message),
            actions: [
              IconButton(
                key: ArchSampleKeys.deleteBroadcastButton,
                tooltip: ArchSampleLocalizations.of(context).deleteBroadcast,
                icon: Icon(Icons.delete),
                onPressed: () {
                  broadcastBloc.deleteBroadcast.add(broadcast.id);
                  Navigator.pop(context, broadcast);
                },
              ),
              IconButton(
                key: ArchSampleKeys.editBroadcastButton,
                tooltip: ArchSampleLocalizations.of(context).editBroadcast,
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return BroadcastAddEditScreen(
                          broadcast: broadcast,
                          broadcastsInteractor: widget.broadcastInteractor,
                          rankInteractor: widget.rankInteractor,
                          updateBroadcast: broadcastBloc.updateBroadcast.add,
                          key: ArchSampleKeys.editBroadcastScreen,
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
              children: <Widget>[Text("Hello World !")],
            ),
          ),
        );
      },
    );
  }
}
