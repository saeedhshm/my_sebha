import 'package:flutter/material.dart';
import 'package:my_sebha/screens/azkar_home.dart';
import 'package:my_sebha/screens/info_screen.dart';
import 'package:my_sebha/screens/sebha_counter_screen.dart';
import 'package:my_sebha/view_models/azkar_home_view_model.dart';
import 'package:provider/provider.dart';

class TabsHomeScreen extends StatefulWidget {
  @override
  _TabsHomeScreenState createState() => _TabsHomeScreenState();
}

enum Tabs { azkar, sebha, info}

class _TabsHomeScreenState extends State<TabsHomeScreen> {
  Tabs tabs = Tabs.azkar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabs == Tabs.azkar
          ? AppBar(title: Text('الأذكار'),centerTitle: true,)
          :tabs == Tabs.sebha ? AppBar(
              title: Text('سبحتي'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
//    _showMyDialog();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings_backup_restore,
                    color: Colors.white,
                  ),
                  onPressed: () {
//    counter = 0;
                    setState(() {});
                  },
                ),
              ],
            ) : AppBar(title: Text('عن التطبيق'),centerTitle: true,),
      body: tabs == Tabs.azkar ? ChangeNotifierProvider(
        create: (_)=>AzkarHomeViewModel(),
        child: AzkarHomeScreen(),
      ) :tabs == Tabs.sebha ? SebhaCounterScreen():InfoScreen(),
      bottomNavigationBar: Container(
//        padding: EdgeInsets.all(16),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
              onPressed: () {
//                setState(() {
//                  tabs = Tabs.azkar;
//                });
              },
              child: Text(
                'الادعية والاذكار',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
              onPressed: () {
//                setState(() {
//                  tabs = Tabs.sebha;
//                });
              },
              child: Text(
                'السبحة',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
              onPressed: (){
//                setState(() {
//                  tabs = Tabs.info;
//                });
              },
              child: Icon(Icons.info,color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}
