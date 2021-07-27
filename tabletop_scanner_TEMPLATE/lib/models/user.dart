import 'package:sqflite/sqflite.dart';
import 'package:tabletop_scanner/enums/id_type.dart';
import 'package:tabletop_scanner/utilities/database_helper.dart';

const TABLE_NAME_USER = 'user';

class User {
  int? id;
  String firstName;
  String lastName;
  // IdType idType;
  String idText;

  User(
      {this.id,
      required this.firstName,
      required this.lastName,
      // required this.idType,
      required this.idText});

  // String get name {
  //   return this.lastName + ", " + this.firstName;
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name_first': firstName,
  //     'name_last': lastName,
  //     'id_type': idType.index,
  //     'id_text': idText
  //   };
  // }

  // static User fromMap(Map map) {
  //   return User(
  //       id: map['id'],
  //       firstName: map['name_first'],
  //       lastName: map['name_last'],
  //       idType: IdType.values[map['id_type']],
  //       idText: map['id_text']);
  // }

  // static Future<User> load(int id) async {
  //   var database = await DatabaseHelper.instance.database;
  //   var results =
  //       await database.query(TABLE_NAME_USER, where: 'id = ?', whereArgs: [id]);
  //   if (results.isNotEmpty) {
  //     return User.fromMap(results[0]);
  //   } else {
  //     return User(
  //         id: 0,
  //         firstName: '',
  //         lastName: '',
  //         idType: IdType.DriversLicense,
  //         idText: '');
  //   }
  // }

  // static Future<List<User>> loadAll() async {
  //   List<User> locations = [];
  //   var database = await DatabaseHelper.instance.database;
  //   var results = await database.query(TABLE_NAME_USER,
  //       orderBy: 'name_last ASC, name_first ASC');
  //   if (results.isNotEmpty) {
  //     for (var result in results) {
  //       final User user = User.fromMap(result);
  //       locations.add(user);
  //     }
  //   }
  //   return locations;
  // }

  // static Future<void> save(User user) async {
  //   var database = await DatabaseHelper.instance.database;

  //   if (user.id == null) {
  //     await database.insert(
  //       TABLE_NAME_USER,
  //       user.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   } else {
  //     await database.update(
  //       TABLE_NAME_USER,
  //       user.toMap(),
  //       where: 'id = ?',
  //       whereArgs: [user.id],
  //     );
  //   }
  // }

  // static Future<void> delete(int userId) async {
  //   var database = await DatabaseHelper.instance.database;

  //   await database.delete(
  //     TABLE_NAME_USER,
  //     where: 'id = ?',
  //     whereArgs: [userId],
  //   );
  // }
}
