import 'package:flutter/material.dart';
import 'package:my_sebha/generals/app_colors.dart';
import 'package:my_sebha/models/zikr.dart';
import 'package:my_sebha/view_models/azkar_cat_view_model.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';


class CategoryAzkarScreen extends StatefulWidget {

  final AzkarCatViewModel _viewModel;
  CategoryAzkarScreen(this._viewModel);
  @override
  _CategoryAzkarScreenState createState() => _CategoryAzkarScreenState(_viewModel);
}

class _CategoryAzkarScreenState extends State<CategoryAzkarScreen> {

  final AzkarCatViewModel _viewModel;
  _CategoryAzkarScreenState(this._viewModel);
  CardController controller; //Use this to trigger swap.

  // var _buttonController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _buttonController = new AnimationController(
    //     duration: new Duration(milliseconds: 1000), value: this);
  }
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _viewModel.category,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkGreen,
          actions: [
            FlatButton(onPressed: null, child: Text('${_viewModel.azkar.length}',style: TextStyle(color: Colors.white70),),)
          ],
          title: Container(
            child: Text(_viewModel.category,
              style: TextStyle(fontFamily: 'DroidSansArabic', fontSize: 20),
            ),
          ),
        ),
        // backgroundColor: AppColors.background,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          color: AppColors.background,
          child: TinderSwapCard(

            totalNum: _viewModel.azkar.length,
            stackNum: _viewModel.azkar.length > 5 ? 5 : _viewModel.azkar.length - 1,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width ,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            minWidth: MediaQuery.of(context).size.width * 0.7,
            minHeight: MediaQuery.of(context).size.height * 0.75,
            cardBuilder: (context,index){
              Zikr zikr = _viewModel.azkar[index];
              return InkWell(
                onTap: (){
                  if(zikr.count == 1)
                  controller.triggerRight();
                  else
                    zikr.count = zikr.count - 1;
                  setState(() {

                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(

                    child: Container(
                      width: MediaQuery.of(context).size.width,

                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blueGrey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('${index + 1}',style: TextStyle(color: Colors.white),)),
                                  ),

                                ),
                                SizedBox(width: 8,),
                                Expanded(child: Text(zikr.description,textAlign: TextAlign.justify,style: TextStyle(
                                  fontSize: 12
                                ),))
                              ],
                            ),

                          ),

                          Container(height: 0.75,color: Colors.grey[300],),
                          Expanded(
                            child: Container(
                              // color: Colors.black.withOpacity(0.7),
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Text(zikr.zekr,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Colors.green[900]),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          ),
                          zikr.reference != "" ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(child: SizedBox()),
                                Text('{ ${zikr.reference} }',style: TextStyle(color: Colors.blueGrey,fontSize: 12),)
                              ],
                            ),
                          ) : Container(),
                          Container(height: 0.75,color: Colors.grey[300],),
                          Row(
                            children: [
                              // SizedBox(width: 16,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical:3.0,horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    border: Border.all(color: Colors.green,width: 1)
                                  ),
                                  child: Row(
                                    children: [
                                      Text('العدد',style: TextStyle(color: Colors.green),),
                                      SizedBox(width: 16,),
                                      Text('${zikr.count}',style: TextStyle(color: Colors.green),)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              FlatButton(
                                onPressed: (){
                                  controller.triggerRight();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical:3.0,horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        border: Border.all(color: Colors.green,width: 1)
                                    ),
                                    child: Row(
                                      children: [
                                        Text('تخطى',style: TextStyle(color: Colors.green),),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                    ),
                  ),
                ),
              );
            },// Card builder
            cardController: controller = CardController( ),
            // allowVerticalMovement: false,

            swipeUpdateCallback:
                (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeDown: false,
            swipeUp: false,
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              /// Get orientation & index of swiped card!
            },
          ),
        ),
      ),
    );
  }

  Widget _card(screenSize){
    return
      new Card(
        color: Colors.transparent,
        elevation: 4.0,
        child: new Container(
          width: screenSize.width / 1.2 ,
          height: screenSize.height / 1.7,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(8.0),
          ),
          child: new Column(
            children: <Widget>[
              new Container(
                width: screenSize.width / 1.2 ,
                height: screenSize.height / 2.2,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.only(
                      topLeft: new Radius.circular(8.0),
                      topRight: new Radius.circular(8.0)),
                  // image: img,
                ),
              ),
              new Container(
                  width: screenSize.width / 1.2 ,
                  height: screenSize.height / 1.7 -
                      screenSize.height / 2.2,

                  child: new Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new SwipeButton(
                        text: "NOPE",
                        onClick: swipeLeft,
                      ),
                      new SwipeButton(
                        text: "LIKE",
                        onClick: swipeRight,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      );
  }

  swipeLeft(){

  }

  swipeRight(){

  }

}

class SwipeButton extends StatelessWidget {

  final String text;
  final Function onClick;

  SwipeButton({this.text,this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
