// import 'package:flutter/material.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:tabletop_scanner/models/game.dart';
// import 'package:tabletop_scanner/screens/game.dart';
// import 'package:tabletop_scanner/utilities/interactions.dart';
// import 'package:tabletop_scanner/widgets/game_item.dart';
// import 'package:tabletop_scanner/widgets/menu.dart';

// class GamesScreen extends StatefulWidget {
//   GamesScreen({Key? key}) : super(key: key);

//   @override
//   _GamesScreenState createState() => _GamesScreenState();
// }

// class _GamesScreenState extends State<GamesScreen> {
//   final String title = "Games";
//   List<Game> _games = [];
//   bool _isLoading = true;

//   Future<void> loadGames() async {
//     setState(() {
//       _isLoading = true;
//     });

//     Game.loadAll().then((games) {
//       setState(() {
//         _games = games;
//         _isLoading = false;
//       });
//     });
//   }

//   Future<void> deleteItem(BuildContext context, int index) async {
//     showDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return AlertDialog(
//             title: const Text('Please Confirm'),
//             content: const Text('Are you sure to remove this game?'),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     Game.delete(_games[index].id!);
//                     loadGames();
//                   },
//                   child: const Text('Yes')),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('No'))
//             ],
//           );
//         });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadGames();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//         ),
//         drawer: const MenuScreen(),
//         body: LoadingOverlay(
//           isLoading: _isLoading,
//           opacity: 0.5,
//           progressIndicator: const CircularProgressIndicator(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: ListView.separated(
//                 itemCount: _games.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final Game game = _games[index];
//                   return GestureDetector(
//                       child: GameItem(
//                         game: game,
//                         onDelete: () => deleteItem(context, index),
//                       ),
//                       onTap: () => openScreen(GameScreen(game: game), context));
//                 },
//                 separatorBuilder: (BuildContext context, int index) =>
//                     const Divider(color: Colors.grey)),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             openScreen(
//                 GameScreen(game: Game(id: null, name: "", upc: "")), context);
//           },
//           child: const Icon(Icons.add),
//           backgroundColor: Colors.blue,
//         ));
//   }
// }
