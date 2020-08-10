import 'package:flutter/material.dart';
import 'package:my_sebha/db_helper/db_helper.dart';
import 'package:my_sebha/models/zikr.dart';


class SebhaCounterViewModel extends ChangeNotifier{
//  int counter = 0;

  Zikr _customSebhaCounter;
  String sebhaTitle;
  int sebhaCount;
  DBHelper _dbHelper;
  String _CustomZikrTable = 'CustomZikr';


  SebhaCounterViewModel(){
    String creatingDB = '''
    CREATE TABLE $_CustomZikrTable(id INTEGER PRIMARY KEY AUTOINCREMENT, zikrName TEXT, count INTEGER, zikrType TEXT, isFavourite VARCHAR(1))
    ''';
    _dbHelper = DBHelper(creatingDB);
    _customSebhaCounter = Zikr(count: 10,zikrName: 'سبحان الله وبحمده');
    sebhaTitle = _customSebhaCounter.zikrName;
    sebhaCount = _customSebhaCounter.count;
  }

  addNewSebha(){

    Zikr sebhaCounter = Zikr(
      count: 100,
      zikrName: 'استغفر الله العظيم وأتوب إليه',
      zikrType: 'user_zikr'
    );

  _dbHelper.insert(table: _CustomZikrTable, map: sebhaCounter.toMap());
  }

  Future<List<Zikr>> retrieveUserZikr() async{
    List<Zikr> userAzkar = List();
    var listOfMap = await _dbHelper.retrieve(table: _CustomZikrTable);

    for(var map in listOfMap){
      Zikr userZikr = Zikr.fromMap(map);
      userAzkar.add(userZikr);
    }
    return userAzkar;
  }

  Future<void> deleteZikr(int id) async{
    await  _dbHelper.delete(table: _CustomZikrTable, id: id);
  }

}