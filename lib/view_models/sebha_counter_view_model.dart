import 'package:flutter/material.dart';
import 'package:my_sebha/db_helper/db_helper.dart';
import 'package:my_sebha/db_helper/json_helper.dart';
import 'package:my_sebha/models/my_zikr.dart';


class SebhaCounterViewModel extends ChangeNotifier{
//  int counter = 0;

  MyZikr currentSebha;
  double _sebhaCounter = 0.0;
  DBHelper _dbHelper;
  String _CustomZikrTable = 'CustomZikr';
  List<MyZikr> myAzkar = List();


  SebhaCounterViewModel(){
    String creatingDB = '''
    CREATE TABLE $_CustomZikrTable(id INTEGER PRIMARY KEY AUTOINCREMENT, zikrName TEXT, count INTEGER, isFavourite VARCHAR(1))
    ''';
    _dbHelper = DBHelper(creatingDB);
    currentSebha = MyZikr(count: 10,zikrName: 'سبحان الله وبحمده');

  }

  setCurrentSebha(MyZikr zikr){
    currentSebha = zikr;
    _sebhaCounter = 0;
    notifyListeners();
  }
  Future<void> addNewSebha({@required MyZikr zikr}) async{

    await _dbHelper.insert(table: _CustomZikrTable, map: zikr.toMap());
    notifyListeners();
  }

  Future<List<MyZikr>> retrieveUserZikr() async{
    List<MyZikr> userAzkar = List();

    var listOfMap = await _dbHelper.retrieve(table: _CustomZikrTable);
    myAzkar.clear();
    print(listOfMap);
    for(var map in listOfMap){
      print(map);
      MyZikr userZikr = MyZikr.fromMap(map);
      myAzkar.add(userZikr);
    }
    notifyListeners();
    return userAzkar;
  }

  Future<void> deleteZikr(int id) async{
    await  _dbHelper.delete(table: _CustomZikrTable, id: id);
    for(int i=0; i<myAzkar.length;i++)
      if(myAzkar[i].id == id)
        myAzkar.removeAt(i);
    notifyListeners();
  }

  Future<void> toggleFavorite({@required MyZikr zikr}) async{
    zikr.isFavourite = !zikr.isFavourite;
    await _dbHelper.update(table: _CustomZikrTable, map: zikr.toMap());
    notifyListeners();
  }

  void incrementCounter(){
    _sebhaCounter++;
    notifyListeners();
  }

  double get sebhaCounter => _sebhaCounter;

  void resetCounter(){
    _sebhaCounter = 0;
    notifyListeners();
  }

}