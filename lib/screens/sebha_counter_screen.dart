import 'package:flutter/services.dart';
import 'package:my_sebha/models/my_zikr.dart';
import 'package:my_sebha/screens/my_azkar_list_home.dart';
import 'package:my_sebha/view_models/sebha_counter_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';


class SebhaCounterScreen extends StatelessWidget {

//  double counter = 0;
  Color sebhaColor = Colors.green;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//  SebhaCounterViewModel _sebhaCounterViewModel;

  checkVibration() async {
    bool canVibrate = await Vibrate.canVibrate;

    print('the phone canVibrate $canVibrate');

  }

  _SebhaCounterScreenState(){
//    _sebhaCounterViewModel = SebhaCounterViewModel();
  }

  @override
  Widget build(BuildContext context) {
final _sebhaCounterViewModel = Provider.of<SebhaCounterViewModel>(context);
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
    _showMyDialog(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings_backup_restore,
              color: Colors.white,
            ),
            onPressed: () {
            _sebhaCounterViewModel.resetCounter();

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
                  child: Text(_sebhaCounterViewModel.currentSebha.zikrName,style: TextStyle(fontSize: 25,color: Colors.white, ),textAlign: TextAlign.center,),
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
                if(_sebhaCounterViewModel.sebhaCounter == _sebhaCounterViewModel.currentSebha.count-1)
                  Vibrate.vibrate();

                if(_sebhaCounterViewModel.sebhaCounter < _sebhaCounterViewModel.currentSebha.count)
                  _sebhaCounterViewModel.incrementCounter();


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

                  max: _sebhaCounterViewModel.currentSebha.count.toDouble(),
                  initialValue: _sebhaCounterViewModel.sebhaCounter,
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
                      child: Text('${value.toInt()}/${_sebhaCounterViewModel.currentSebha.count}',style: TextStyle(
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
          ChangeNotifierProvider(
            create: (_)=>_sebhaCounterViewModel,
            child: _settingModalBottomSheet(context),
          );
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

  Widget _settingModalBottomSheet(context)  {
    final _sebhaCounterViewModel = Provider.of<SebhaCounterViewModel>(context,listen: false);

      _sebhaCounterViewModel.retrieveUserZikr();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return ChangeNotifierProvider.value(
            value: _sebhaCounterViewModel,
            child: MyAzkarListHome(),
          );
        }
    );
  }

  Future<void> _showMyDialog(context) async {
    MyZikr zikr = MyZikr();
    final _viewModel = Provider.of<SebhaCounterViewModel>(context,listen: false);
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
                  await _viewModel.addNewSebha(zikr: zikr);
                  Navigator.of(context).pop();
                  _showErrorDialog(true,context);
                }else {
                  Navigator.of(context).pop();
                  print('no zikr found ==== ${zikr.zikrName} == ${zikr.count}');
                  _showErrorDialog(false,context);
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

  Future<void> _showErrorDialog(bool done,BuildContext context) async {
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
                  _showMyDialog(context);
              },
            ),
          ],
        );
      },
    );
  }
}
