import 'package:flutter/material.dart';
import 'package:my_sebha/screens/category_azkar_screen.dart';
import 'package:my_sebha/view_models/azkar_cat_view_model.dart';
import 'package:my_sebha/view_models/azkar_home_view_model.dart';
import 'package:provider/provider.dart';

class AzkarHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<AzkarHomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('الأذكار'),centerTitle: true,),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        child: ListView.builder(
          itemCount: Provider.of<AzkarHomeViewModel>(context).azkarCategories.length,
          itemBuilder: (context,index){
            String e = _viewModel.azkarCategories.toList()[index];
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CategoryAzkarScreen(AzkarCatViewModel(azkar: _viewModel.getAzkarOfCat(e),category: e));
                }));
              },
              child: Card(

                child: Container(
//                  height: 50,
//                    width: MediaQuery.of(context).size.width/2 - 30,
                  padding: EdgeInsets.all(5),
                  child: Text(e),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
