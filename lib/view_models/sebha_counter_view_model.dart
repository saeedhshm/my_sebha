import 'package:flutter/material.dart';
import 'package:my_sebha/models/custom_sebha_counter.dart';


class SebhaCounterViewModel extends ChangeNotifier{
//  int counter = 0;

  CustomSebhaCounter _customSebhaCounter;
  String sebhaTitle;
  int sebhaCount;

  SebhaCounterViewModel(){
    _customSebhaCounter = CustomSebhaCounter(count: 10,sebhaTitle: 'سبحان الله وبحمده');
    sebhaTitle = _customSebhaCounter.sebhaTitle;
    sebhaCount = _customSebhaCounter.count;
  }

  addNewSebha(){
    sebhaTitle = 'استغفر الله العظيم الذي لا إله إلا هو الحي القيوم واتوب اليه';
    sebhaCount = 100;
//    notifyListeners();
  }



}