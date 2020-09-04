

import 'package:flutter/material.dart';
import 'package:my_sebha/db_helper/json_helper.dart';
import 'package:my_sebha/models/zikr.dart';

class AzkarHomeViewModel extends ChangeNotifier{
  List<Zikr> _azkar = List();

  AzkarHomeViewModel(){
    _getAllAzkar();
  }

  _getAllAzkar() async{
   var jsonArray = await ReadJson().parseJson();
   for(var json in jsonArray) {
//     print(json);
     Zikr zikr = Zikr.fromJson(json);
     _azkar.add(zikr);
   }
   azkarCategories;
   notifyListeners();
  }
  Set<String> get azkarCategories {
    Set<String> categ = Set();
    for(var zikr in _azkar){
      categ.add(zikr.category);
    }

    return categ;
  }

  List<Zikr> getAzkarOfCat(String category){
    List<Zikr> azkar = List();
    for(var zikr in _azkar){
      if(zikr.category == category){
        azkar.add(zikr);
      }
    }
    return azkar;
  }

}