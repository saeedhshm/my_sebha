import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(
        title: Text(
          'الأذكار',
          style: TextStyle(fontFamily: 'Antic Decorative', letterSpacing: 3.0),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.green.withOpacity(0.3),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: GridView.builder(
          itemCount:
              Provider.of<AzkarHomeViewModel>(context).azkarCategories.length,
          itemBuilder: (context, index) {
            String e = _viewModel.azkarCategories.toList()[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CategoryAzkarScreen(AzkarCatViewModel(
                      azkar: _viewModel.getAzkarOfCat(e), category: e));
                }));
              },
              child: Container(
//                  height: 50,
//                    width: MediaQuery.of(context).size.width/2 - 30,

                padding: EdgeInsets.all(8),
                child: Center(
                    child: Text(e,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: 3,wordSpacing: 3),

                        textAlign: TextAlign.center)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                    // color: Colors.greenAccent,
                    // backgroundBlendMode: BlendMode.colorDodge,
                    image: DecorationImage(

                        image: ExactAssetImage('assets/image/bg4.png'),
                        colorFilter: ColorFilter.mode(Colors.green, BlendMode.overlay),
                        fit: BoxFit.contain)),
              ),
            );
          },
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
      ),
    );
  }
}
