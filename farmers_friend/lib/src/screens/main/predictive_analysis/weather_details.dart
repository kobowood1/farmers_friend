import 'package:farmers_friend/src/model/ForecastData.dart';
import 'package:farmers_friend/src/model/WeatherData.dart';
import 'package:farmers_friend/src/res/Res.dart';
import 'package:farmers_friend/src/store/ForecastStore.dart';
import 'package:farmers_friend/src/store/WeatherStore.dart';
import 'package:farmers_friend/src/ui/ForecastDetailPage.dart';
import 'package:farmers_friend/src/ui/forecast/Forecast.dart';
import 'package:farmers_friend/src/ui/forecast/ForecastList.dart';
import 'package:farmers_friend/src/ui/weather/Weather.dart';
import 'package:farmers_friend/src/ui/widgets/DotPageIndicator.dart';
import 'package:farmers_friend/src/ui/widgets/TextWithExponent.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class GreenWeatherDescriptionSection extends StoreWatcher {

  @override
  void initStores(ListenToStore listenToStore) {
    listenToStore(weatherStoreToken);
    actionUpdateWeather.call(); // Initial load
  }

  @override
  Widget build(BuildContext context, Map<StoreToken, Store> stores) {
    WeatherStore store = stores[weatherStoreToken];
    WeatherData weatherData = store.weatherData;
    WeatherInfo weatherInfo = new WeatherInfo(weatherData);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("October Weather Forecast", style: TextStyle(fontFamily: "PlayFair", 
        fontSize: ScreenUtil.instance.setSp(40), fontWeight: FontWeight.bold, color: Colors.black),),
        SizedBox(height: ScreenUtil.instance.setHeight(14),),
        Text(weatherInfo.getDescription(), style: TextStyle(fontFamily: "Roboto",
        fontStyle: FontStyle.normal, fontWeight: FontWeight.normal, 
        fontSize: ScreenUtil.instance.setSp(26),
        color: Color(getColorHexFromStr("#777a7b"))),),
        SizedBox(height: ScreenUtil.instance.setHeight(13),),
        Container(
          width: MediaQuery.of(context).size.width - 50,
          height: ScreenUtil.instance.setHeight(100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 3,
                color: Colors.black.withOpacity(0.4),
                offset: Offset(3.0, 5.0)              )
            ],
            color: Color(getColorHexFromStr("#36ab80"))
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(30.0),
            vertical: ScreenUtil.instance.setHeight(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("October Weather Forecast", style: TextStyle(fontFamily: "PlayFair", 
                  fontSize: ScreenUtil.instance.setSp(28), fontWeight: FontWeight.bold, color: Colors.white),),
                  SizedBox(height: ScreenUtil.instance.setHeight(11),),
                Text(weatherInfo.getDescription(), style: TextStyle(fontFamily: "Roboto",
                  fontStyle: FontStyle.normal, fontWeight: FontWeight.normal, 
                  fontSize: ScreenUtil.instance.setSp(22),
                  color: Colors.white),),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WeatherDetails extends StatefulWidget {
  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 720, height: 720
    )..init(context);

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(50.0),
            vertical: ScreenUtil.instance.setHeight(50.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                topRow(),
                SizedBox(height: ScreenUtil.instance.setHeight(23.0)),
                middleColumn(),
                SizedBox(height: ScreenUtil.instance.setHeight(23.0)),
               bottomForecastColumn(),
                
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget topRow(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: <Widget>[
        Container(
          height: ScreenUtil.instance.setHeight(30),
          width: ScreenUtil.instance.setHeight(40),
          child: Image.asset("assets/images/28.png"),
          
        ),
        Spacer(),
        Container(
          child: Icon(Icons.close, color: Colors.black, size: 26,),
        )
      ],
    );
  }

  Widget middleColumn(){
    return GreenWeatherDescriptionSection();
    
    //  Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     Text("October Weather Forecast", style: TextStyle(fontFamily: "PlayFair", 
    //     fontSize: ScreenUtil.instance.setSp(40), fontWeight: FontWeight.bold, color: Colors.black),),
    //     SizedBox(height: ScreenUtil.instance.setHeight(14),),
    //     Text("Sunny with 20% chance of rain", style: TextStyle(fontFamily: "Roboto",
    //     fontStyle: FontStyle.normal, fontWeight: FontWeight.normal, 
    //     fontSize: ScreenUtil.instance.setSp(26),
    //     color: Color(getColorHexFromStr("#777a7b"))),),
    //     SizedBox(height: ScreenUtil.instance.setHeight(13),),
    //     Container(
    //       width: MediaQuery.of(context).size.width - 50,
    //       height: ScreenUtil.instance.setHeight(100),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //         boxShadow: <BoxShadow>[
    //           BoxShadow(
    //             blurRadius: 3,
    //             color: Colors.black.withOpacity(0.4),
    //             offset: Offset(3.0, 5.0)              )
    //         ],
    //         color: Color(getColorHexFromStr("#36ab80"))
    //       ),
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(30.0),
    //         vertical: ScreenUtil.instance.setHeight(20.0)),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text("October Weather Forecast", style: TextStyle(fontFamily: "PlayFair", 
    //               fontSize: ScreenUtil.instance.setSp(28), fontWeight: FontWeight.bold, color: Colors.white),),
    //               SizedBox(height: ScreenUtil.instance.setHeight(11),),
    //             Text("Sunny with 20% chance of rain", style: TextStyle(fontFamily: "Roboto",
    //               fontStyle: FontStyle.normal, fontWeight: FontWeight.normal, 
    //               fontSize: ScreenUtil.instance.setSp(22),
    //               color: Colors.white),),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget bottomForecastColumn(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Next 5 Days", style: TextStyle(fontFamily: "PlayFair", 
        fontSize: ScreenUtil.instance.setSp(40), fontWeight: FontWeight.bold, color: Colors.black),),
        SizedBox(height: ScreenUtil.instance.setHeight(12),),
        Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 700,
                child: WeeklyForeCast(),
              ),
              SizedBox(height: 20,),
            ],
          ),
      ],
    );
  }

  Widget weatherForecastTable(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WeeklyForeCast()
      ],
    );
  }
}


class WeeklyForeCast extends StoreWatcher {

  @override
  Widget build(BuildContext context, Map<StoreToken, Store> stores) {
    ForecastStore store = stores[forecastStoreToken];
    if (store.forecastByDay == null) return new Container();

    return new Stack(
      children: <Widget>[
        // new Image(
        //   image: new AssetImage("assets/images/limitless_ai.png"),
        //   fit: BoxFit.fitWidth,
        // ),
        new Container(
          child: new ForcastNestedTab(store.forecastByDay),
        ),
      ],
    );
  }


  @override
  void initStores(ListenToStore listenToStore) {
    listenToStore(forecastStoreToken);
    updateForecast.call(); // Initial load
  }
}


final weekdayFormat = new DateFormat('EEE');

class ForcastNestedTab extends StatefulWidget {
  var _forecastByDay;
  ForcastNestedTab(this._forecastByDay);

  @override
  _ForcastNestedTabState createState() {
    return new _ForcastNestedTabState(_forecastByDay);
  }
}

class _ForcastNestedTabState extends State<ForcastNestedTab> {
  var currentPage = 0;
  List<List<ForecastWeather>> _forecastByDay;

  _ForcastNestedTabState(this._forecastByDay);

  @override
  void didUpdateWidget(ForcastNestedTab oldWidget) {
    setState(() {
      this._forecastByDay = widget._forecastByDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDateTime;
    final pageCount = _forecastByDay != null ? _forecastByDay.length : 0;

    if (_forecastByDay != null) {
      if (_forecastByDay[currentPage].length > 0) {
        currentDateTime = _forecastByDay[currentPage][0].dateTime;
      }
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new _ForecastWeekNestedTabs(currentDateTime, currentPage, pageCount),
        new Expanded(
            child: new PageView.builder(
              itemBuilder: (BuildContext context, int index) =>
              new ForecastList(_forecastByDay[index]),
              itemCount: pageCount,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) => this.setState(() {this.currentPage = index;}),
            )),
      ],
    );
  }
}

class _ForecastWeekNestedTabs extends StatelessWidget {
  final DateTime dateTime;
  final int currentPage;
  final int pageCount;

  _ForecastWeekNestedTabs(this.dateTime, this.currentPage, this.pageCount);


  @override
  Widget build(BuildContext context) {
    final textStyle = new TextStyle(fontSize: 24.0);
    final int dayOfMonth = dateTime != null ? dateTime.day : 0;
    String dayMonthSuffix = "";

    final weekDay = weekdayFormat.format(dateTime).toString();
    if (dayOfMonth == 1) {
      dayMonthSuffix += "st";
    } else if (dayOfMonth == 2) {
      dayMonthSuffix += "nd";
    } else {
      dayMonthSuffix += "th";
    }


    return new Container(
      child: new Container(
        child: new Stack(
          children: <Widget>[
            new Container(
              child: new Text(weekDay, style: TextStyle(fontSize: ScreenUtil.instance.setSp(26))),
            ),
            new Align(
              child: new DotPageIndicator(this.currentPage, this.pageCount),
              alignment: FractionalOffset.center,
            ),
            new Positioned(
                child: new TextWithExponent(
                  dayOfMonth.toString(),
                  dayMonthSuffix,
                  textSize: 12.0,
                  exponentTextSize: 12.0,
                ),
                right: 36.0),
          ],
        ),
        padding: new EdgeInsets.symmetric(vertical: 8.0),
      ),
      decoration: new BoxDecoration(
          border: new Border(bottom: new BorderSide(color: Colors.black12))),
    );
  }
}

class ForecastNestedList extends StatelessWidget {
  final List<ForecastWeather> _forecast;

  ForecastNestedList(this._forecast);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          new _ForecastNestedListItem(_forecast[index]),
      itemCount: _forecast == null ? 0 : _forecast.length,
    );
  }
}

final timeFormat = new DateFormat('HH');

class _ForecastNestedListItem extends StatelessWidget {
  static ForecastWeather weather;

  _ForecastNestedListItem(weather);


  @override
  Widget build(BuildContext context) {
    final time = timeFormat.format(weather.dateTime);

    return new Material(
        child: new InkWell(
            onTap: () => {},
            child: new Container(
                height: 65.0,
                padding:
                    new EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: new Stack(
                  children: <Widget>[
                    new Align(
                      child: new TextWithExponent(
                        time, "h",
                        textSize: 20.0,
                        exponentTextSize: 12.0,
                        ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.35,
                      child: new Container(
                        child: new Image.asset(
                          weather.condition.getAssetString(),
                          height: 46.0,
                          width: 46.0,
                          fit: BoxFit.scaleDown,
                        ),
               
                      ),
                    ),
                    new Positioned(
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            width: 80.0,
                            alignment: FractionalOffset.centerRight,
                            child: new Text(
                              weather.temperature + "°C",

                              style: new TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                      right: 0.0,
                      top: 12.0,
                    )
                  ],
                ))));
  }
}



// class NestedTabBar extends StatefulWidget {
//   var _forecastByDay;
//   NestedTabBar(this._forecastByDay);
//   @override
//   _NestedTabBarState createState() => _NestedTabBarState(this._forecastByDay);
// }

// class _NestedTabBarState extends State<NestedTabBar> with TickerProviderStateMixin {
//   TabController _nestedTabController;
//    DateTime dateTime;
//    int currentPage;
//    int pageCount;
//    List<List<ForecastWeather>> _forecastByDay;

//   _NestedTabBarState(this._forecastByDay);

//   @override
//   void initState() {
//     super.initState();

//     _nestedTabController = new TabController(length: 4, vsync: this);
//   }

//   @override
//   void didUpdateWidget(ForcastNestedTab oldWidget) {
//     setState(() {
//       this._forecastByDay = widget._forecastByDay;
//     });
//   }



  
//   void dispose(){
//     super.dispose();
//     _nestedTabController.dispose();
//   }



 








//   @override
//   Widget build(BuildContext context) {
//     final textStyle = new TextStyle(fontSize: 24.0);
//     final int dayOfMonth = dateTime != null ? dateTime.day : 0;
//     String dayMonthSuffix = "";

//     final weekDay = weekdayFormat.format(dateTime).toString();
//     if (dayOfMonth == 1) {
//       dayMonthSuffix += "st";
//     } else if (dayOfMonth == 2) {
//       dayMonthSuffix += "nd";
//     } else {
//       dayMonthSuffix += "th";
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         TabBar(
//           controller: _nestedTabController,
//           isScrollable: true,
//           indicatorColor: Color(getColorHexFromStr("#df0298")),
//           labelColor: Color(getColorHexFromStr("#de000000")),
//           unselectedLabelColor: Color(getColorHexFromStr("#d4d5dd")),
//           tabs: <Widget>[
//             // All Tab
//             Tab(
//               child: Text("Mon", style: TextStyle(fontSize: ScreenUtil.instance.setSp(24.0)),),
//             ),
//             Row(
//               children: <Widget>[
//                 Container(
//                   height: 20,
//                   width: 20,
//                   child: Icon(Icons.call_made, color: Color(getColorHexFromStr("#d4d5dd"),), size: 14,),
//                 ),
//                 // Sent Tab
//                 Tab(
//                   child: Text("Tue", style: TextStyle(fontSize: ScreenUtil.instance.setSp(24.0)),),
//                 ),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Container(
//                   height: 20,
//                   width: 20,
//                   child: Icon(Icons.call_received, color: Color(getColorHexFromStr("#d4d5dd"),), size: 14,)
//                 ),
                
//                 /// Received Tab
//                 Tab(
//                   child: Text("Wed", style: TextStyle(fontSize: ScreenUtil.instance.setSp(24.0)),),
//                 ),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Container(
//                   height: 20,
//                   width: 20,
//                   child: Icon(Icons.import_export, color: Color(getColorHexFromStr("#d4d5dd"),), 
//                   size: 14),
//                 ),
//                 // Settlement Tab
//                 Tab(
//                   child: Text("Thu", style: TextStyle(fontSize: ScreenUtil.instance.setSp(24.0))),
//                 ),
//               ],
//             ),
            
//           ],
//         ),
      
//         SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: <Widget>[
//               Container(
//               height: MediaQuery.of(context).size.height - 270,
              
//               child: TabBarView(
//                 controller: _nestedTabController,
//                 children: <Widget>[
//                   FutureBuilder(
//                     // future: WayaServices.fetchUserTransactionList2(widget.token),
//                     builder: (BuildContext context, snapshot){
//                     return Column(
//                     children: <Widget>[
//                       Expanded(
//                         child: Container(
//                           height: 300.0,
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             itemCount: ,
//                             itemBuilder: (BuildContext context, int index){
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
                                  
//                                 ],
//                               );
//                             },
                            
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                     }
//                   ),
                  
//                   // SortedTransactionItemsList(transactionItems: transactionItems,),
//                   // Sent List Items
//                   FutureBuilder(
//                     builder: (BuildContext context, snapshot){
//                   return Column(
//                     children: <Widget>[
//                       Expanded(
//                         child: Container(
//                           height: 300.0,
//                           child: ListView.builder(
//                             itemCount: ,
//                             itemBuilder: (BuildContext context, int index){
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
                                  
                                  
//                                 ],
//                               );
//                             },
                            
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                   }, 
//               ),

//               // SortedTransactionItemsList(transactionItems: getSentTransaction(transactionItems),),
//                   // Received Content
//                   FutureBuilder(
//                     builder: (BuildContext context, snapshot){
//                       return Column(
//                         children: <Widget>[
//                           Expanded(
//                             child: Container(
//                               height: 300.0,
//                               child: ListView.builder(
//                                 itemCount: ,
//                                 itemBuilder: (BuildContext context, int index){
//                                   return Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
                                      
                      
//                                     ],
//                                   );
//                                 },
                                
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),

//                   // SortedTransactionItemsList(transactionItems: getReceivedTransaction(transactionItems),),
//                   FutureBuilder<Object>(
//                     future: null,
//                     builder: (context, snapshot) {
//                       return Column(
//                         children: <Widget>[
//                           Expanded(
//                             child: Container(
//                               height: 300.0,
//                               child: ListView.builder(
//                                 itemCount: ,
//                                 itemBuilder: (BuildContext context, int index){
//                                   return Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
                                      
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                   ),
                  
//                 ],
//               ),
//         ),
//             ],
//           ),
//         )
//       ],
//     );

//   }
//   }