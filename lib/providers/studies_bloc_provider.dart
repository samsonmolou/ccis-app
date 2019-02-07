import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StudiesBlocProvider extends StatefulWidget {
  final Widget child;
  final StudiesListBloc bloc;

  StudiesBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _StudiesBlocProviderState createState() => _StudiesBlocProviderState();

  static StudiesListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_StudiesBlocProvider)
    as _StudiesBlocProvider)
        .bloc;
  }
}

class _StudiesBlocProviderState extends State<StudiesBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _StudiesBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _StudiesBlocProvider extends InheritedWidget {
  final StudiesListBloc bloc;

  _StudiesBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_StudiesBlocProvider old) => bloc != old.bloc;
}