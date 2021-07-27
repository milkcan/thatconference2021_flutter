import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tabletop_scanner/models/user.dart';
import 'package:tabletop_scanner/screens/user.dart';
import 'package:tabletop_scanner/utilities/interactions.dart';

const textstyleGameName = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

class UserItem extends StatelessWidget {
  const UserItem({Key? key, required this.user, required this.onDelete})
      : super(key: key);

  final User user;
  final VoidCallback onDelete;

  void edit(context) {
    // openScreen(UserScreen(user: user), context);
  }

  List<Widget> manageButtons(BuildContext context) {
    return <Widget>[
      IconSlideAction(
        color: Colors.grey,
        icon: Icons.edit,
        onTap: () => edit(context),
      ),
      IconSlideAction(
        color: Colors.red,
        icon: Icons.delete,
        onTap: onDelete,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // children: [Text(user.name, style: textstyleGameName)],
            ),
            secondaryActions: manageButtons(context)));
  }
}
