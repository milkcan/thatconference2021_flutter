import 'package:sqflite/sqflite.dart';
import 'package:tabletop_scanner/models/game.dart';
import 'package:tabletop_scanner/models/user.dart';
import 'package:tabletop_scanner/utilities/database_helper.dart';

const TABLE_NAME_RENTAL = 'rental';

class Rental {
  // int? id;
  // int? userId;
  // User? user;
  // int? gameId;
  // Game? game;
  // DateTime start;
  // DateTime? end;

  // Rental(
  //     {this.id,
  //     this.userId,
  //     this.user,
  //     this.gameId,
  //     this.game,
  //     required this.start,
  //     this.end});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'game_id': gameId,
  //     'user_id': userId,
  //     'start': start.toIso8601String(),
  //     'end': (end == null) ? null : end!.toIso8601String()
  //   };
  // }

  // static Rental fromMap(Map map) {
  //   return Rental(
  //       id: map['id'],
  //       gameId: map['game_id'],
  //       userId: map['user_id'],
  //       start: DateTime.parse(map['start'] ?? DateTime.now().toString()),
  //       end: (map['end'] == null) ? null : DateTime.parse(map['end']));
  // }

  // static Future<Rental> load(int id) async {
  //   var database = await DatabaseHelper.instance.database;
  //   var results = await database
  //       .query(TABLE_NAME_RENTAL, where: 'id = ?', whereArgs: [id]);
  //   if (results.isNotEmpty) {
  //     return Rental.fromMap(results[0]);
  //   } else {
  //     return Rental(
  //         id: 0, gameId: 0, userId: 0, start: DateTime.now(), end: null);
  //   }
  // }

  // static Future<List<Rental>> loadAll() async {
  //   List<Rental> rentals = [];
  //   var database = await DatabaseHelper.instance.database;
  //   var results = await database.query(TABLE_NAME_RENTAL,
  //       where: 'end isnull', orderBy: 'start ASC');
  //   if (results.isNotEmpty) {
  //     for (var result in results) {
  //       final Rental rental = Rental.fromMap(result);
  //       rental.game = await Game.load(rental.gameId!);
  //       if (rental.userId != null) {
  //         rental.user = await User.load(rental.userId!);
  //       }
  //       rentals.add(rental);
  //     }
  //   }
  //   return rentals;
  // }

  // static Future<void> save(Rental rental) async {
  //   var database = await DatabaseHelper.instance.database;

  //   if (rental.id == null) {
  //     await database.insert(
  //       TABLE_NAME_RENTAL,
  //       rental.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   } else {
  //     await database.update(
  //       TABLE_NAME_RENTAL,
  //       rental.toMap(),
  //       where: 'id = ?',
  //       whereArgs: [rental.id],
  //     );
  //   }
  // }

  // static Future<void> delete(int rentalId) async {
  //   var database = await DatabaseHelper.instance.database;

  //   await database.delete(
  //     TABLE_NAME_RENTAL,
  //     where: 'id = ?',
  //     whereArgs: [rentalId],
  //   );
  // }

  // static Future<Rental?> find(int gameId) async {
  //   var database = await DatabaseHelper.instance.database;
  //   var results = await database.query(TABLE_NAME_RENTAL,
  //       where: 'game_id = ? AND end isnull', whereArgs: [gameId]);
  //   if (results.isNotEmpty) {
  //     return Rental.fromMap(results[0]);
  //   } else {
  //     return null;
  //   }
  // }
}
