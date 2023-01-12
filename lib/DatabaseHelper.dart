import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "travelPHDatabase.db";
  static final _databaseVersion = 1;

  static final tableAccounts = 'tableAccounts';
  static final columnAccountID = 'accountID';
  static final columnAccountUsername = 'accountUsername';
  static final columnAccountPassword = 'accountPassword';
  static final columnAccountFirstName = 'accountFirstName';
  static final columnAccountLastName = 'accountLastName';

  static final tableComments = 'tableComments';
  static final columnCommentID = 'commentID';
  static final columnCommentFullName = 'commentFullName';
  static final columnCommentPlaceName = 'commentPlaceName';
  static final columnCommentText = 'commentText';

  static final tablePlaces = 'tablePlaces';
  static final columnPlaceID = 'placeID';
  static final columnPlaceName = 'placeName';
  static final columnPlaceLocation = 'placeLocation';
  static final columnPlaceDescription = 'placeDescription';
  static final columnPlaceImage = 'placeImage';
  static final columnPlaceAccountID = 'placeAccountID';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableAccounts (
            $columnAccountID INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnAccountUsername TEXT NOT NULL,
            $columnAccountPassword TEXT NOT NULL,
            $columnAccountFirstName TEXT NOT NULL,
            $columnAccountLastName TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $tableComments (
            $columnCommentID INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnCommentFullName TEXT NOT NULL,
            $columnCommentPlaceName TEXT NOT NULL,
            $columnCommentText TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $tablePlaces (
            $columnPlaceID INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnPlaceName TEXT NOT NULL,
            $columnPlaceLocation TEXT NOT NULL,
            $columnPlaceDescription TEXT NOT NULL,
            $columnPlaceImage TEXT NOT NULL,
            $columnPlaceAccountID INTEGER NOT NULL
          )
          ''');
  }

  //insert an account into the table
  Future<int> insertAccount(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(tableAccounts, row);
  }

  //get account's username method
  Future<Object?> getAccountUsername(String username) async {
    Database db = await instance.database;
    var result = await db.query(
      tableAccounts,
      columns: [columnAccountUsername],
      where: '$columnAccountUsername = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      //if result is not empty
      return result[0]
          [columnAccountUsername]; //return the first result's account username
    } else {
      return null;
    }
  }

  //get account's full details
  Future<Map<String, Object?>?> getAccountDetails(String username) async {
    Database db = await instance.database;
    var result = await db.query(
      tableAccounts,
      where: '$columnAccountUsername = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return result[0]; //return the first result
    } else {
      return null;
    }
  }

  //get the comments of a Place
  Future<List<Map>> getCommentOfPlace(String placeName) async {
    Database db = await instance.database;
    return await db.query(
      tableComments,
      where: '$columnCommentPlaceName = ?',
      whereArgs: [placeName],
    );
  }

  //insert an account into the table
  Future<int> insertPlaceIntoTable(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(tablePlaces, row);
  }

  Future<int> deletePlaceInsideTable(String placeName, int accountID) async {
    Database db = await instance.database;
    return await db.delete(tablePlaces,
        where: '$columnPlaceName = ? AND $columnPlaceAccountID = ?',
        whereArgs: [placeName, accountID]);
  }

  Future<bool> checkIfPlaceIsAlreadyBookmarked(
      String placeName, int accountID) async {
    Database db = await instance.database;
    var result = await db.query(tablePlaces,
        where: '$columnPlaceName = ? AND $columnPlaceAccountID = ?',
        whereArgs: [placeName, accountID]);

    if (result.isNotEmpty) {
      return true; //return the first result
    } else {
      return false;
    }
  }

  //get saved places of an account
  Future<List<Map>> getPlacesOfAccount(int accountID) async {
    Database db = await instance.database;
    return await db.query(
      tablePlaces,
      where: '$columnPlaceAccountID = ?',
      whereArgs: [accountID],
    );
  }

  //insert a comment into the table
  Future<int> insertCommentIntoTable(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(tableComments, row);
  }

//updates account details
  Future<int> updateAccount(Map<String, dynamic> row, String username) async {
    Database db = await instance.database;
    return await db.update(tableAccounts, row,
        where: '$columnAccountUsername = ?', whereArgs: [username]);
  }

//updates the Full Name in all the comments the account made
  Future<int> updateAccountComment(
      Map<String, dynamic> row, String fullName) async {
    Database db = await instance.database;
    return await db.update(tableComments, row,
        where: '$columnCommentFullName = ?', whereArgs: [fullName]);
  }
}
