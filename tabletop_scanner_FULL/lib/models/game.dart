import 'package:sqflite/sqflite.dart';
import 'package:tabletop_scanner/utilities/database_helper.dart';

const TABLE_NAME_GAME = 'game';

class Game {
  int? id;
  String name;
  String upc;

  Game({this.id, required this.name, required this.upc});

  @override
  bool operator ==(other) {
    return (other is Game) && other.name == name && other.upc == upc;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'upc': upc};
  }

  static Game fromMap(Map map) {
    return Game(id: map['id'], name: map['name'], upc: map['upc']);
  }

  static Future<Game> load(int id) async {
    var database = await DatabaseHelper.instance.database;
    var results =
        await database.query(TABLE_NAME_GAME, where: 'id = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      return Game.fromMap(results[0]);
    } else {
      return Game(id: 0, name: '', upc: '');
    }
  }

  static Future<List<Game>> loadAll() async {
    List<Game> locations = [];
    var database = await DatabaseHelper.instance.database;
    var results = await database.query(TABLE_NAME_GAME, orderBy: 'name ASC');
    if (results.isNotEmpty) {
      for (var result in results) {
        final Game game = Game.fromMap(result);
        locations.add(game);
      }
    }
    return locations;
  }

  static Future<void> save(Game game) async {
    var database = await DatabaseHelper.instance.database;

    if (game.id == null) {
      await database.insert(
        TABLE_NAME_GAME,
        game.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      await database.update(
        TABLE_NAME_GAME,
        game.toMap(),
        where: 'id = ?',
        whereArgs: [game.id],
      );
    }
  }

  static Future<void> delete(int gameId) async {
    var database = await DatabaseHelper.instance.database;

    await database.delete(
      TABLE_NAME_GAME,
      where: 'id = ?',
      whereArgs: [gameId],
    );
  }

  static Future<Game?> find(String upc) async {
    var database = await DatabaseHelper.instance.database;
    var results = await database
        .query(TABLE_NAME_GAME, where: 'upc = ?', whereArgs: [upc]);
    if (results.isNotEmpty) {
      return Game.fromMap(results[0]);
    } else {
      return null;
    }
  }
}
