import 'package:flutter/material.dart';
import 'package:my_sebha/db_helper/db_helper.dart';
import 'package:my_sebha/db_helper/json_helper.dart';
import 'package:my_sebha/models/my_zikr.dart';


class SebhaCounterViewModel extends ChangeNotifier{
//  int counter = 0;

  MyZikr _customSebhaCounter;
  String sebhaTitle;
  int sebhaCount;
  DBHelper _dbHelper;
  String _CustomZikrTable = 'CustomZikr';


  SebhaCounterViewModel(){
    ReadJson().parseJson();
    String creatingDB = '''
    CREATE TABLE $_CustomZikrTable(id INTEGER PRIMARY KEY AUTOINCREMENT, zikrName TEXT, count INTEGER, zikrType TEXT, isFavourite VARCHAR(1))
    ''';
    _dbHelper = DBHelper(creatingDB);
    _customSebhaCounter = MyZikr(count: 10,zikrName: 'سبحان الله وبحمده');
    sebhaTitle = _customSebhaCounter.zikrName;
    sebhaCount = _customSebhaCounter.count;
  }

  setCurrentSebha(MyZikr zikr){
    sebhaTitle = zikr.zikrName;
    sebhaCount = zikr.count;
  }
  Future<void> addNewSebha({@required MyZikr zikr}) async{


    zikr.zikrType = 'user_zikr';

    await _dbHelper.insert(table: _CustomZikrTable, map: zikr.toMap());
  }

  Future<List<MyZikr>> retrieveUserZikr() async{
    List<MyZikr> userAzkar = List();
    var listOfMap = await _dbHelper.retrieve(table: _CustomZikrTable);


    print(listOfMap);
    for(var map in listOfMap){
      print(map);
      MyZikr userZikr = MyZikr.fromMap(map);
      userAzkar.add(userZikr);
    }
    return userAzkar;
  }

  Future<void> deleteZikr(int id) async{
    await  _dbHelper.delete(table: _CustomZikrTable, id: id);
  }

  Future<void> toggleFavorite({@required MyZikr zikr}) async{
    zikr.isFavourite = !zikr.isFavourite;
    await _dbHelper.update(table: _CustomZikrTable, map: zikr.toMap());
  }

}