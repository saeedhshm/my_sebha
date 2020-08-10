import 'package:sqflite/sqflite.dart';


class DBHelper{
  var _db;
  openDB()async{
    _db = await openDatabase('moselm_sebha.db');
  }

  closeDB() async{
    await _db.close();
  }
}