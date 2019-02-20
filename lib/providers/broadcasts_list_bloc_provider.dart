import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BroadcastListsBlocProvider extends StatefulWidget {
  final Widget child;
  final BroadcastListListBloc bloc;

  BroadcastListsBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _BroadcastListsBlocProviderState createState() => _BroadcastListsBlocProviderState();

  static BroadcastListListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_BroadcastListsBlocProvider)
    as _BroadcastListsBlocProvider)
        .bloc;
  }
}

class _BroadcastListsBlocProviderState extends State<BroadcastListsBlocProvider> {
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
  final BroadcastListListBloc bloc;

  _BroadcastListsBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BroadcastListsBlocProvider old) => bloc != old.bloc;
}