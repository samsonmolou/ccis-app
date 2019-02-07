import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommunitiesBlocProvider extends StatefulWidget {
  final Widget child;
  final CommunitiesListBloc bloc;

  CommunitiesBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _CommunitiesBlocProviderState createState() => _CommunitiesBlocProviderState();

  static CommunitiesListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_CommunitiesBlocProvider)
    as _CommunitiesBlocProvider)
        .bloc;
  }
}

class _CommunitiesBlocProviderState extends State<CommunitiesBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _CommunitiesBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _CommunitiesBlocProvider extends InheritedWidget {
  final CommunitiesListBloc bloc;

  _CommunitiesBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_CommunitiesBlocProvider old) => bloc != old.bloc;
}