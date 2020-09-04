

import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int counter = 0;

  incrementer(){
    counter++;
    notifyListeners();
  }
}