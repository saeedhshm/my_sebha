import 'package:flutter/material.dart';
import 'package:my_sebha/models/zikr.dart';
import 'package:my_sebha/view_models/azkar_cat_view_model.dart';

class CategoryAzkarScreen extends StatefulWidget {

  final AzkarCatViewModel _viewModel;
  CategoryAzkarScreen(this._viewModel);
  @override
  _CategoryAzkarScreenState createState() => _CategoryAzkarScreenState(_viewModel);
}

class _CategoryAzkarScreenState extends State<CategoryAzkarScreen> {

  final AzkarCatViewModel _viewModel;
  _CategoryAzkarScreenState(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_viewModel.category),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: ListView.builder(
          itemCount: _viewModel.azkar.length,
          itemBuilder: (context,index){
            Zikr zikr = _viewModel.azkar[index];
            return Card(
              child: Text(zikr.zekr),
            );
          },
        ),
      ),
    );
  }
}
