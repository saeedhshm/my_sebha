import 'package:flutter/material.dart';
import 'package:my_sebha/view_models/sebha_counter_view_model.dart';
import 'package:provider/provider.dart';

class MyAzkarListHome extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
    final _sebhaCounterViewModel = Provider.of<SebhaCounterViewModel>(context);
    _sebhaCounterViewModel.retrieveUserZikr();

    return Scaffold(
//            backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: InkWell(child: Icon(Icons.close),onTap: (){
          Navigator.of(context).pop();
        },),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _sebhaCounterViewModel.myAzkar.length,
          itemBuilder: (context,index){
            return Card(

              child: ListTile(
                onTap: (){
                  print(_sebhaCounterViewModel.myAzkar[index].toMap());
                  _sebhaCounterViewModel.setCurrentSebha(_sebhaCounterViewModel.myAzkar[index]);
                  Navigator.of(context).pop();
//                        setState(() {
//                          counter = 0;
//                        });
                },
                title: Container(

                  child: Text(_sebhaCounterViewModel.myAzkar[index].zikrName ?? 'no zikr',
                    style: TextStyle(fontSize: 18,color: Colors.green[900],)
                    ,textAlign: TextAlign.end,),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Theme.of(context).accentColor,width: 0.5)
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text('العدد ${_sebhaCounterViewModel.myAzkar[index].count}'),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.delete,color: Theme.of(context).accentColor,),
                      onPressed: () async{
                        await _sebhaCounterViewModel.deleteZikr(_sebhaCounterViewModel.myAzkar[index].id);
//                        setState(() {
//
//                        });
                      },
                    ),
//                          SizedBox(width: 10,),
                    IconButton(
                      icon: Icon(Icons.edit,color: Theme.of(context).accentColor,),
                      onPressed: (){},
                    ),
//                          SizedBox(width: 10,),
                    IconButton(
                      icon: Icon(_sebhaCounterViewModel.myAzkar[index].isFavourite ? Icons.favorite : Icons.favorite_border ,color: Theme.of(context).accentColor,),
                      onPressed: (){
                        _sebhaCounterViewModel.toggleFavorite(zikr: _sebhaCounterViewModel.myAzkar[index]);
                      },
                    ),
                  ],
                ),
//                    trailing: ,
              ),
//                    elevation: 0,
            );
          },
        ),
        decoration: BoxDecoration(
//                color: Theme.of(context).backgroundColor
        ),
      ),

    );
  }
}
