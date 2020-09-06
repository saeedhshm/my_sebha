import 'package:flutter/material.dart';
import 'package:my_sebha/screens/azkar_home.dart';
import 'package:my_sebha/screens/info_screen.dart';
import 'package:my_sebha/screens/sebha_counter_screen.dart';
import 'package:my_sebha/view_models/azkar_home_view_model.dart';
import 'package:my_sebha/view_models/sebha_counter_view_model.dart';
import 'package:my_sebha/view_models/tabs_view_model.dart';
import 'package:provider/provider.dart';

class TabsHomeScreen extends StatelessWidget {

//  Tabs tabs = Tabs.azkar;
  @override
  Widget build(BuildContext context) {

    final _viewModel = Provider.of<TabsViewModel>(context);
    return Scaffold(

      body:getCurrentScreen(_viewModel.currentTab),
      bottomNavigationBar: Container(
//        padding: EdgeInsets.all(16),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
              onPressed: () {
                _viewModel.setCurrentTab(Tabs.azkar);

              },
              child: Text(
                'الادعية والاذكار',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
              onPressed: () {
                _viewModel.setCurrentTab(Tabs.sebha);

              },
              child: Text(
                'السبحة',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
              onPressed: (){
                _viewModel.setCurrentTab(Tabs.info);

              },
              child: Icon(Icons.info,color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }

  Widget getCurrentScreen(Tabs currentTab){
    return  currentTab == Tabs.azkar ? ChangeNotifierProvider(
      create: (_)=>AzkarHomeViewModel(),
      child: AzkarHomeScreen(),
    ) :currentTab == Tabs.sebha ? ChangeNotifierProvider(
      create: (_)=>SebhaCounterViewModel(),
      child: SebhaCounterScreen(),
    ):InfoScreen();
  }
}
