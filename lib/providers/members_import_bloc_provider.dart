import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MembersImportBlocProvider extends StatefulWidget {
  final Widget child;
  final MembersImportBloc bloc;

  MembersImportBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _MembersImportBlocProviderState createState() => _MembersImportBlocProviderState();

  static MembersImportBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_MembersImportBlocProvider)
    as _MembersImportBlocProvider)
        .bloc;
  }
}

class _MembersImportBlocProviderState extends State<MembersImportBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _MembersImportBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _MembersImportBlocProvider extends InheritedWidget {
  final MembersImportBloc bloc;

  _MembersImportBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_MembersImportBlocProvider old) => bloc != old.bloc;
}