import 'package:flutter/material.dart';


enum Tabs { azkar, sebha, info}

class TabsViewModel extends ChangeNotifier{
  Tabs currentTab = Tabs.azkar;

  setCurrentTab(Tabs currentTab){
    this.currentTab = currentTab;
    notifyListeners();
  }

}