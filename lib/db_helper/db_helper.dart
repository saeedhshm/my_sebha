import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_sebha/models/my_zikr.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';


class DBHelper{
   Future<Database> _database;
   final String db_name = 'azkary.db';
   final String _createTable;

   DBHelper(this._createTable){
     openDB();
   }

  openDB()async{
    // Open the database and store the reference.

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath,db_name);

    _database =  openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      path,
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
//          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
          _createTable,
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,

    );
    _database.then((value) {
      print(value.path);
    });
  }


   // Define a function that inserts dogs into the database
   Future<void> insert({@required String table,@required Map<String, dynamic> map}) async {
     // Get a reference to the database.
     final Database db = await _database;

     // Insert the Dog into the correct table. You might also specify the
     // `conflictAlgorithm` to use in case the same dog is inserted twice.
     //
     // In this case, replace any previous data.
     var result = await db.insert(
       table,
       map,
       conflictAlgorithm: ConflictAlgorithm.replace,
     );

     print(result);
   }

   // A method that retrieves all the dogs from the dogs table.
   Future<dynamic> retrieve({@required String table}) async {
     // Get a reference to the database.
     final Database db = await _database;

     print(db.path);
     // Query the table for all The Dogs.
     final List<Map<String, dynamic>> maps = await db.query(table);
     print(maps);

     // Convert the List<Map<String, dynamic> into a List<Dog>.
     return maps;
   }

   Future<void> delete({@required String table,@required int id}) async {
     // Get a reference to the database.
     final db = await _database;

     // Remove the Dog from the Database.
     var result = await db.delete(
       table,
       // Use a `where` clause to delete a specific dog.
       where: "id = ?",
       // Pass the Dog's id as a whereArg to prevent SQL injection.
       whereArgs: [id],
     );
     print(result);
   }

   Future<void> update({@required String table,@required Map<String, dynamic> map}) async {
     // Get a reference to the database.
     final db = await _database;

     // Update the given Dog.
     var result = await db.update(
       table,
       map,
       // Ensure that the Dog has a matching id.
       where: "id = ?",
       // Pass the Dog's id as a whereArg to prevent SQL injection.
       whereArgs: [map['id']],
     );
     print(result);
   }


   createTable() async {
    _database.then((value){
      value.execute(    "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
      value.setVersion(1);
    });
    final Future<Database> database = openDatabase(
      // Set the path to the database.
        join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs.
        onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
    "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
    );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
    );

  }

  closeDB() async{
    await _database.then((value) => value.close());
  }
}