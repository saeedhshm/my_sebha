import 'package:flutter/services.dart';
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
      appBar: AppBar(
        title: Text('سبحتي'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              _sebhaCounterViewModel.addNewSebha();
              counter = 0;
              setState(() {

              });
            },
          ),
          IconButton(
            icon: Icon(Icons.settings_backup_restore,color: Colors.white,),
            onPressed: (){
              counter = 0;
              setState(() {

              });
            },
          ),

        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,

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

               setState(() {

               });
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

  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Container(
              child: SingleChildScrollView(
                child: new Column(
                  children: [
                    Card(
                    child: ListTile(
                      title: Container(

                        child: Text('يتتا نتل يصل لصيل نتيلص لنتصيلتليص لصيل  نل يصنتلتلت نيصتلنل يصتل',
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
                          Text('العدد ١٠٠'),
                          Spacer(),
                          Icon(Icons.delete,color: Theme.of(context).accentColor,),
                          SizedBox(width: 10,),
                          Icon(Icons.edit,color: Theme.of(context).accentColor,)
                        ],
                      ),
//                    trailing: ,
                    ),
                      elevation: 0,
                  ),
                    Card(
                      child: ListTile(
                        title: Container(

                          child: Text('يتتا نتل يصل لصيل نتيلص لنتصيلتليص لصيل  نل يصنتلتلت نيصتلنل يصتل',
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
                            Text('العدد ١٠٠'),
                            Spacer(),
                            Icon(Icons.delete,color: Theme.of(context).accentColor,),
                            SizedBox(width: 10,),
                            Icon(Icons.edit,color: Theme.of(context).accentColor,)
                          ],
                        ),
//                    trailing: ,
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Container(

                          child: Text('يتتا نتل يصل لصيل نتيلص لنتصيلتليص لصيل  نل يصنتلتلت نيصتلنل يصتل',
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
                            Text('العدد ١٠٠'),
                            Spacer(),
                            Icon(Icons.delete,color: Theme.of(context).accentColor,),
                            SizedBox(width: 10,),
                            Icon(Icons.edit,color: Theme.of(context).accentColor,)
                          ],
                        ),
//                    trailing: ,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor
              ),
            ),
          );
        }
    );
  }
}
