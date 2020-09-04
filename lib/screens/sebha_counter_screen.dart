import 'package:flutter/services.dart';
import 'package:my_sebha/models/my_zikr.dart';
import 'package:my_sebha/view_models/sebha_counter_view_model.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';


class SebhaCounterScreen extends StatefulWidget {

  @override
  _SebhaCounterScreenState createState() => _SebhaCounterScreenState();
}

class _SebhaCounterScreenState extends State<SebhaCounterScreen> {

  double counter = 0;
  Color sebhaColor = Colors.green;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SebhaCounterViewModel _sebhaCounterViewModel;

  checkVibration() async {
    bool canVibrate = await Vibrate.canVibrate;

    print('the phone canVibrate $canVibrate');

  }

  _SebhaCounterScreenState(){
    _sebhaCounterViewModel = SebhaCounterViewModel();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkVibration();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,

      backgroundColor: Theme.of(context).backgroundColor,
      appBar:  AppBar(
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
      ) ,

      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.bottomCenter,
//        color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(_sebhaCounterViewModel.sebhaTitle,style: TextStyle(fontSize: 25,color: Colors.white, ),textAlign: TextAlign.center,),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.green,width: 2)
                  ),
                ),
              ),
            ),


            InkWell(
              onTap: (){
                if(counter == _sebhaCounterViewModel.sebhaCount-1)
                  Vibrate.vibrate();

                if(counter < _sebhaCounterViewModel.sebhaCount)
                   counter++;

//               setState(() {
//
//               });
              },
              child: Container(
//                alignment: Alignment.bottomCenter,,
              width : MediaQuery.of(context).size.width - 33,
                height : MediaQuery.of(context).size.width - 33,
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    animationEnabled: false,
                    customColors: CustomSliderColors(
                      trackColor: Colors.green[100]
                    ),
                    angleRange: 360,
                    size: 150,

//                    spinnerMode: true,
                    startAngle: 270,
                    customWidths: CustomSliderWidths(
                      trackWidth: 10,
//                      handlerSize: 100
                    ),
                    infoProperties: InfoProperties(
                    )
                  ),
                  min: 0,

                  max: _sebhaCounterViewModel.sebhaCount.toDouble(),
                  initialValue: counter,
                  onChange: (double value) {
                    // callback providing a value while its being changed (with a pan gesture)

                  },
                  onChangeStart: (double startValue) {
                    // callback providing a starting value (when a pan gesture starts)
                  },
                  onChangeEnd: (double endValue) {
                    // ucallback providing an ending value (when a pan gesture ends)
                  },
                  innerWidget: (double value) {
                    // use your custom widget inside the slider (gets a slider value from the callback)
                    return Center(
                      child: Text('${value.toInt()}/${_sebhaCounterViewModel.sebhaCount}',style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      ),textAlign: TextAlign.center,),
                    );
                  },
                ),

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: sebhaColor,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: (){
          _settingModalBottomSheet(context);
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Text('الأذكار المحفوظة',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            border: Border.all(color: Colors.white,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),
        ),
      ),

    );
  }

  void _settingModalBottomSheet(context) async {

    List<MyZikr> userAzkar = await _sebhaCounterViewModel.retrieveUserZikr();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Scaffold(
//            backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            leading: InkWell(child: Icon(Icons.close),onTap: (){
              Navigator.of(context).pop();
            },),
          ),
            body: Container(
              child: ListView.builder(
                itemCount: userAzkar.length,
                itemBuilder: (context,index){
                  return Card(

                    child: ListTile(
                      onTap: (){
                        print(userAzkar[index].toMap());
                        _sebhaCounterViewModel.setCurrentSebha(userAzkar[index]);
                        Navigator.of(context).pop();
//                        setState(() {
//                          counter = 0;
//                        });
                      },
                      title: Container(

                        child: Text(userAzkar[index].zikrName ?? 'no zikr',
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
                          Text('العدد ${userAzkar[index].count}'),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete,color: Theme.of(context).accentColor,),
                            onPressed: () async{
                              await _sebhaCounterViewModel.deleteZikr(userAzkar[index].id);
//                              setState(() {
//
//                              });
                            },
                          ),
//                          SizedBox(width: 10,),
                          IconButton(
                            icon: Icon(Icons.edit,color: Theme.of(context).accentColor,),
                            onPressed: (){},
                          ),
//                          SizedBox(width: 10,),
                          IconButton(
                            icon: Icon(userAzkar[index].isFavourite ? Icons.favorite : Icons.favorite_border ,color: Theme.of(context).accentColor,),
                            onPressed: (){
                              _sebhaCounterViewModel.toggleFavorite(zikr: userAzkar[index]);
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
    );
  }

  Future<void> _showMyDialog() async {
    MyZikr zikr = MyZikr();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('إضافة ذكر جديد'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  onChanged: (value){
                    if(value.isNotEmpty)
                      zikr.zikrName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'الذكر',
                    hintText: 'الذكر المراد إدخاله'
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    if(value.isNotEmpty)
                      zikr.count = int.parse(value);
                  },

                  decoration: InputDecoration(
                      labelText: 'العدد',
                      hintText: 'عدد الذكر في كل مرة'
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('تم'),

              onPressed: () async{
                if((zikr.zikrName.isNotEmpty) && ( zikr.count != 0)) {
                  await _sebhaCounterViewModel.addNewSebha(zikr: zikr);
                  Navigator.of(context).pop();
                  _showErrorDialog(true);
                }else {
                  Navigator.of(context).pop();
                  print('no zikr found ==== ${zikr.zikrName} == ${zikr.count}');
                  _showErrorDialog(false);
                }
              },
            ),
            FlatButton(
              child: Text('إغلاق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(bool done) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(done ? 'تم' : 'هناك خطأ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(done ? 'تمت الإضافة بنجاح' : 'لم تتم الإضافة'),
                !done ? Text('لم يتم إدخال الذكر او العدد') : Container()
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if(!done)
                  _showMyDialog();
              },
            ),
          ],
        );
      },
    );
  }
}
