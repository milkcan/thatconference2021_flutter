import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tabletop_scanner/models/game.dart';
import 'package:tabletop_scanner/screens/game.dart';
import 'package:tabletop_scanner/utilities/interactions.dart';

const textstyleGameName = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

class GameItem extends StatelessWidget {
  const GameItem({Key? key, required this.game, required this.onDelete})
      : super(key: key);

  final Game game;
  final VoidCallback onDelete;

  void edit(context) {
    openScreen(GameScreen(game: game), context);
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
              children: [Text(game.name, style: textstyleGameName)],
            ),
            secondaryActions: manageButtons(context)));
  }
}
