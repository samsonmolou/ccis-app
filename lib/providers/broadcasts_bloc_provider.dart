import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BroadcastsBlocProvider extends StatefulWidget {
  final Widget child;
  final BroadcastsListBloc bloc;

  BroadcastsBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _BroadcastsBlocProviderState createState() => _BroadcastsBlocProviderState();

  static BroadcastsListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_BroadcastListsBlocProvider)
    as _BroadcastListsBlocProvider)
        .bloc;
  }
}

class _BroadcastsBlocProviderState extends State<BroadcastsBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _BroadcastListsBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _BroadcastListsBlocProvider extends InheritedWidget {
  final BroadcastsListBloc bloc;

  _BroadcastListsBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BroadcastListsBlocProvider old) => bloc != old.bloc;
}