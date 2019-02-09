import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_app/providers/members_bloc_provider.dart';
import 'package:ccis_app/widgets/members/member_list.dart';
import 'package:ccis_app/widgets/members/member_search.dart';
import 'package:ccis_app/widgets/shared/navigation_drawer.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/material.dart';
import 'package:ccis_repository_flutter/ccis_repository_flutter.dart';
import 'package:ccis_app/screens/members/member_add_edit_screen.dart';
import 'package:ccis_app/dependency_injector/member_injector.dart';


class MemberScreen extends StatefulWidget {

  MemberScreen()
      : super(key: ArchSampleKeys.memberScreen);

  @override
  State<StatefulWidget> createState() {
    return MemberScreenState();
  }
}

class MemberScreenState extends State<MemberScreen> {

  // Pour la gestion de la recherche des membres
  SearchMemberSearchDelegate _delegate;

  @override
  void initState() {
    super.initState();
    _delegate = SearchMemberSearchDelegate(
      initBloc: () =>
          MemberSearchBloc(MemberInjector.of(context).membersInteractor)
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membersBloc = MembersBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).members),
        actions: _buildActions(
          membersBloc,
        ),
      ),
      drawer: NavigationDrawer(key: ArchSampleKeys.navigationDrawer),
      body: MemberList(),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addMemberFab,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return MemberAddEditScreen(
                    key: ArchSampleKeys.addMemberScreen,
                    addMember: membersBloc.addMember.add,
                    communitiesInteractor: CommunitiesInteractor(
                        ReactiveCommunitiesRepositoryFlutter(
                            repository: CommunitiesRepositoryFlutter(
                                communitiesMetadata: CommunitiesMetadata()))),
                    studiesInteractor: StudiesInteractor(
                        ReactiveStudiesRepositoryFlutter(
                            repository: StudiesRepositoryFlutter(
                                studiesMetadata: StudiesMetadata()))),
                  );
                },
              )
          );
        },
        child: Icon(Icons.add),
        tooltip: ArchSampleLocalizations.of(context).addMember,
      ),
    );
  }

  List<Widget> _buildActions(
      MembersListBloc membersBloc,
      ) {
    return [
      IconButton(
        tooltip: ArchSampleLocalizations.of(context).searchMember,
        icon: const Icon(Icons.search),
        onPressed: () async {
          await showSearch<String>(
            context: context,
            delegate: _delegate,
          );
        },
      )
    ];
  }
}