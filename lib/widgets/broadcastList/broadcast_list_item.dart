import 'package:ccis_app/ccis_app.dart';
import 'package:ccis_blocs/ccis_blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BroadcastListItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Member member;

  final String _simpleValue1 = 'Menu item value one';
  final String _simpleValue2 = 'Menu item value two';
  final String _simpleValue3 = 'Menu item value three';
  String _simpleValue;


  BroadcastListItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.member,
  });

  void showMenuSelection(String value) {
    if (<String>[_simpleValue1, _simpleValue2, _simpleValue3].contains(value))
      _simpleValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.memberItem(member.id),
      onDismissed: onDismissed,
      background: Container(
          color: Theme.of(context).primaryColor,
          child: const ListTile(
              leading: Icon(Icons.delete, color: Colors.white, size: 36.0)
          )
      ),
      secondaryBackground: Container(
          color: Theme.of(context).primaryColor,
          child: const ListTile(
              trailing: Icon(Icons.edit, color: Colors.white, size: 36.0)
          )
      ),
      child: ListTile(
        onTap: onTap,
        trailing: PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            onSelected: showMenuSelection,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                  value: 'Preview',
                  child: ListTile(
                      leading: Icon(Icons.visibility),
                      title: Text('Preview')
                  )
              ),
              const PopupMenuItem<String>(
                  value: 'Share',
                  child: ListTile(
                      leading: Icon(Icons.person_add),
                      title: Text('Share')
                  )
              ),
              const PopupMenuItem<String>(
                  value: 'Get Link',
                  child: ListTile(
                      leading: Icon(Icons.link),
                      title: Text('Get link')
                  )
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                  value: 'Remove',
                  child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Remove')
                  )
              )
            ]
        ),
        title: Text(
          member.fullName                                                                                                                                                                                                                   ,
          key: ArchSampleKeys.memberItemHead(member.id),
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          member.residenceBedroom + " - " + member.community.name + " - " + member.phoneNumber,
          key: ArchSampleKeys.memberItemSubhead(member.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),

      ),
    );
  }
}
