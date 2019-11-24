import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:keboen_coding_pertemuan3/src/models/users_model.dart';
// Default Boolean di SQFLITE itu 1/0 1=True 0=false

class UsersDBHelper {
  static final UsersDBHelper _instance = new UsersDBHelper.internal();
  UsersDBHelper.internal();

  factory UsersDBHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await setDB();
    return _db;
  }

  Future<Database> setDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Users");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Users("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "username VARCHAR(101) NOT NULL,"
        "email VARCHAR(101) NOT NULL,"
        "password VARCHAR(101) NOT NULL,"
        "avatar VARCHAR(101))");
  }

  Future<int> addUser(Users users) async {
    var dbClient = await db;
    int count = await dbClient.insert("Users", users.toMap());

    return count;
  }

  Future<List<Users>> getAllUsers() async {
    var dbClient = await db;
    var list = await dbClient.query("Users");
    List<Users> userList = List<Users>();
    for (var i = 0; i < list.length; i++) {
      userList.add(Users.fromMap(list[i]));
    }

    return userList;
  }

  Future<int> updateUser(Users users, int id) async {
    var dbClient = await db;
    int count = await dbClient
        .update("Users", users.toMap(), where: "id = ?", whereArgs: [id]);
    return count;
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    int count =
        await dbClient.delete("Users", where: "id = ?", whereArgs: [id]);
    return count;
  }
}
