import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RankBlocProvider extends StatefulWidget {
  final Widget child;
  final RankBloc bloc;

  RankBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _RankBlocProviderState createState() => _RankBlocProviderState();

  static RankBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_RankBlocProvider)
    as _RankBlocProvider)
        .bloc;
  }
}

class _RankBlocProviderState extends State<RankBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _RankBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _RankBlocProvider extends InheritedWidget {
  final RankBloc bloc;

  _RankBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_RankBlocProvider old) => bloc != old.bloc;
}