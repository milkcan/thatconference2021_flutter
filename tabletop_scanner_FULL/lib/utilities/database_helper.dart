import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'ttscanner.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database!;
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE game(id INTEGER PRIMARY KEY, name TEXT, upc TEXT)");
      await db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY, name_first TEXT, name_last TEXT, id_type INTEGER, id_text TEXT)");
      await db.execute(
          "CREATE TABLE rental(id INTEGER PRIMARY KEY, game_id INTEGER NOT NULL, user_id INTEGER NOT NULL, start DATETIME, end DATETIME)");
    });
  }
}
