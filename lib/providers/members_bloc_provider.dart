import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ccis_blocs/ccis_blocs.dart';

class MembersBlocProvider extends StatefulWidget {
  final Widget child;
  final MembersListBloc bloc;

  MembersBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _MembersBlocProviderState createState() => _MembersBlocProviderState();

  static MembersListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_MembersBlocProvider)
    as _MembersBlocProvider)
        .bloc;
  }
}

class _MembersBlocProviderState extends State<MembersBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _MembersBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _MembersBlocProvider extends InheritedWidget {
  final MembersListBloc bloc;

  _MembersBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_MembersBlocProvider old) => bloc != old.bloc;
}