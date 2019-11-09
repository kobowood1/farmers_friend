import 'dart:async';

import 'package:farmers_friend/src/model/WeatherData.dart';
import 'package:farmers_friend/src/screens/main/predictive_analysis/weather_details.dart';
import 'package:farmers_friend/src/store/WeatherStore.dart';
import 'package:farmers_friend/src/ui/weather/Weather.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:farmers_friend/src/utility/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class CityTemperatureWidget extends StoreWatcher {
  final String country;
  CityTemperatureWidget({this.country});
  // Future initializeCountry() async{
  //   country = await getCountryFromPref();
    
  // }


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
    
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(100),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            elevation: 10.0,
            child: Image.asset("assets/images/forcast_bg.png"),
          ),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 3,
                color: Colors.black.withOpacity(0.4),
                offset: Offset(10.0, 10.0)              )
            ],
          ),
        ),
        Positioned(
          top: ScreenUtil.instance.setHeight(9),
          left: ScreenUtil.instance.setWidth(32),
          child: Text(this.country.toLowerCase() == "india"? "India": "Ghana", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
          fontFamily: "PlayFair", fontSize: ScreenUtil.instance.setSp(30.0)),),
        ),
        Positioned(
          top: ScreenUtil.instance.setHeight(32),
          left: ScreenUtil.instance.setWidth(32),
          child: Text(this.country.toLowerCase() == "india" ? "Hyderabad": "Techiman", style: TextStyle(color: Colors.white.withOpacity(0.7), 
          fontWeight: FontWeight.w500, 
          fontSize: ScreenUtil.instance.setSp(20.0)),),
        ),
        Positioned(
          bottom: ScreenUtil.instance.setHeight(18),
          left: ScreenUtil.instance.setWidth(32),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "${weatherInfo.getTemperature()}c",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil.instance.setSp(36.0)),
                )
              ]
            ),
          ),
        ),
        Positioned(
          top: ScreenUtil.instance.setHeight(12),
          right: ScreenUtil.instance.setWidth(32),
          child: Image.asset(weatherInfo.getConditionIcon(), width: 26.0, height: 23,),
        ),
        Positioned(
          bottom: ScreenUtil.instance.setHeight(18),
          right: ScreenUtil.instance.setWidth(32),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: weatherInfo.getDescription(),
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil.instance.setSp(22.0)),
                )
              ]
            ),
          ),
        ),
      ],
    );
  }
}

class PredictiveAnalysisScreen extends StatefulWidget {
  @override
  _PredictiveAnalysisScreenState createState() => _PredictiveAnalysisScreenState();
}

class _PredictiveAnalysisScreenState extends State<PredictiveAnalysisScreen> with StoreWatcherMixin {
  int currentIndex = 0;
  String country = "";
  String username = "";
  String _timeString;

  

  @override
    void initState(){
      super.initState();
      _timeString = _formatDateTime(DateTime.now());
      Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
      initializeDetails();
    }


    void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy HH:mm:ss').format(dateTime);
  }

  Future initializeDetails() async{
    String musername = await getNameFromPref();
    String mcountry = await getCountryFromPref();
    setState(() {
      username = musername;
      country = mcountry;
    });
  }

  


  @protected
  void initStores(ListenToStore listenToStore) {
    listenToStore(weatherStoreToken);
    actionUpdateWeather.call(); // Initial load
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 720,
      height: 720
    )..init(context);

    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: ScreenUtil.instance.setHeight(30.0),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(50.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text("Hello $username", style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.instance.setSp(36.0), color: Colors.black),),
                    Spacer(),
                    Text("$_timeString", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.instance.setSp(22.0), color: Color(getColorHexFromStr("#777a7b"))),),
                  ],
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(23.0),),
                // weatherForcastStackWidget(),
                // SizedBox(height: ScreenUtil.instance.setHeight(23.0),),
                CityTemperatureWidget(country: country,),
                SizedBox(height: ScreenUtil.instance.setHeight(30.0),),
                Text("October", style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
                fontSize: ScreenUtil.instance.setSp(36.0), color: Colors.black),),
                SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                Text("Farmers Friend wants you to know:",  style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w400,
                fontSize: ScreenUtil.instance.setSp(24.0), color: Color(getColorHexFromStr("#777a7b"))),),
                SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                middleCardDetailsColumn(),
                SizedBox(height: 10,),
                Container(
                  child: Divider(

                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil.instance.setHeight(16.0),),
          bottomChartColumnWidget(context),
        ],
      ),
      
    );
  }

  Widget weatherForcastStackWidget(){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(100),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            elevation: 10.0,
            child: Image.asset("assets/images/forcast_bg.png"),
          ),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 3,
                color: Colors.black.withOpacity(0.4),
                offset: Offset(10.0, 10.0)              )
            ],
          ),
        ),
        Positioned(
          top: ScreenUtil.instance.setHeight(9),
          left: ScreenUtil.instance.setWidth(32),
          child: Text("Techiman", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
          fontFamily: "PlayFair", fontSize: ScreenUtil.instance.setSp(30.0)),),
        ),
        Positioned(
          top: ScreenUtil.instance.setHeight(32),
          left: ScreenUtil.instance.setWidth(32),
          child: Text("Bono-East - Ghana", style: TextStyle(color: Colors.white.withOpacity(0.7), 
          fontWeight: FontWeight.w500, 
          fontSize: ScreenUtil.instance.setSp(20.0)),),
        ),
        Positioned(
          bottom: ScreenUtil.instance.setHeight(18),
          left: ScreenUtil.instance.setWidth(32),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "28°c",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil.instance.setSp(36.0)),
                )
              ]
            ),
          ),
        ),
        Positioned(
          top: ScreenUtil.instance.setHeight(12),
          right: ScreenUtil.instance.setWidth(32),
          child: Image.asset("assets/images/clouds.png", width: 26.0, height: 23,),
        ),
        Positioned(
          bottom: ScreenUtil.instance.setHeight(18),
          right: ScreenUtil.instance.setWidth(32),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "70% chance of Rain",
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil.instance.setSp(22.0)),
                )
              ]
            ),
          ),
        ),
      ],
    );
  }

  Widget middleCardDetailsColumn(){
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil.instance.setHeight(420),
          decoration: BoxDecoration(
            color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(10.0), 
            vertical: ScreenUtil.instance.setHeight(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Material(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context){
                              return WeatherDetails();
                            }
                          ));
                        },
                        child: Container(
                          height: ScreenUtil.instance.setHeight(140),
                          width: ScreenUtil.instance.setWidth(296),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil.instance.setHeight(12),
                                horizontal: ScreenUtil.instance.setHeight(12),
                                ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Image.asset("assets/images/yellow_cloud.png", height: 30, width: 30,
                                    alignment: Alignment.topLeft,),
                                  ),
                                  SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                                  Text("Weather Forecast", style: TextStyle(fontFamily: "PlayFair",
                                  fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(28.0)),),
                                  SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                                  Text("Sunny with 20%\nchance of rain",style: TextStyle(fontFamily: "Roboto",
                                   height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                  color: Color(getColorHexFromStr("#777a7b"))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil.instance.setHeight(140),
                      width: ScreenUtil.instance.setWidth(296),
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil.instance.setHeight(12),
                            horizontal: ScreenUtil.instance.setHeight(12),
                            ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Image.asset("assets/images/raindrop.png", height: 30, width: 30,
                                alignment: Alignment.topLeft,),
                              ),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Text("Rainfall", style: TextStyle(fontFamily: "PlayFair",
                              fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(28.0)),),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Text("Light Rains%\nexpected.",style: TextStyle(fontFamily: "Roboto",
                               height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                              color: Color(getColorHexFromStr("#777a7b"))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(14.0),),
                Container(
                  height: ScreenUtil.instance.setHeight(115),
                  width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(120),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil.instance.setHeight(12),
                            horizontal: ScreenUtil.instance.setHeight(12),
                            ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             // SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Text("Pest Attack", style: TextStyle(fontFamily: "PlayFair",
                              fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(28.0)),),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Watch out for: ",
                                      style: TextStyle(fontFamily: "Roboto", wordSpacing: 1.5,
                                      height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: "Stem borers",
                                      style: TextStyle(fontFamily: "Roboto",
                                      decoration: TextDecoration.underline, wordSpacing: 1.5,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      color: Colors.black)
                                      ),
                                      // TextSpan(
                                      // text: ", ",
                                      // style: TextStyle(fontFamily: "Roboto", wordSpacing: 1.5,
                                      // height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      // color: Color(getColorHexFromStr("#777a7b")))
                                      // ),
                                      // TextSpan(
                                      // text: "Worms",
                                      // style: TextStyle(fontFamily: "Roboto", decoration: TextDecoration.underline,
                                      // fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      // color: Colors.black, wordSpacing: 1.5,)
                                      // ),
                                      TextSpan(
                                      text: " and ",
                                      style: TextStyle(fontFamily: "Roboto", wordSpacing: 1.5,
                                      height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: country.toLowerCase() == "india" ? "Leaf worms.": "Seed bugs",
                                      style: TextStyle(fontFamily: "Roboto", decoration: TextDecoration.underline, wordSpacing: 1.5,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      color: Colors.black)
                                      ),
                                  ]
                                ),
                              ),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Text("Learn More", style: TextStyle(fontFamily: "Roboto", color: Color(getColorHexFromStr("#36ab80")),
                              fontWeight: FontWeight.w500, fontSize: ScreenUtil.instance.setSp(22.0)),),
                            ],
                          ),
                        ),
                  ),
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(14.0),),
                Container(
                  height: ScreenUtil.instance.setHeight(115),
                  width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(120),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil.instance.setHeight(12),
                            horizontal: ScreenUtil.instance.setHeight(12),
                            ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             // SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Row(
                                children: <Widget>[
                                  Text("Disease Attack", style: TextStyle(fontFamily: "PlayFair",
                                  fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(28.0)),),
                                  Spacer(),
                                  Container(
                                    child: Image.asset("assets/images/alert.png", width: 18.0, height: 18.0,),
                                  )
                                ],
                              ),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Watch out for: ",
                                      style: TextStyle(fontFamily: "Roboto", wordSpacing: 1.5,
                                      height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: "Rice Blast",
                                      style: TextStyle(fontFamily: "Roboto",
                                      decoration: TextDecoration.underline, wordSpacing: 1.5,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      color: Colors.black)
                                      ),
                                      // TextSpan(
                                      // text: ", ",
                                      // style: TextStyle(fontFamily: "Roboto", wordSpacing: 1.5,
                                      // height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      // color: Color(getColorHexFromStr("#777a7b")))
                                      // ),
                                      // TextSpan(
                                      // text: "Worms",
                                      // style: TextStyle(fontFamily: "Roboto", decoration: TextDecoration.underline,
                                      // fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      // color: Colors.black, wordSpacing: 1.5,)
                                      // ),
                                      TextSpan(
                                      text: " and ",
                                      style: TextStyle(fontFamily: "Roboto", wordSpacing: 1.5,
                                      height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: country.toLowerCase() == "india" ? "Sheath Blight.": "Blast",
                                      style: TextStyle(fontFamily: "Roboto", decoration: TextDecoration.underline, wordSpacing: 1.5,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(22.0),
                                      color: Colors.black)
                                      ),
                                  ]
                                ),
                              ),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Text("Learn More", style: TextStyle(fontFamily: "Roboto", color: Color(getColorHexFromStr("#36ab80")),
                              fontWeight: FontWeight.w500, fontSize: ScreenUtil.instance.setSp(22.0)),),
                            ],
                          ),
                        ),
                  ),
                ),
                  
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomChartColumnWidget(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil.instance.setWidth(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Market Prices", style: TextStyle(fontFamily: "PlayFair", fontSize: ScreenUtil.instance.setSp(34),
              fontWeight: FontWeight.bold),),
              SizedBox(height: ScreenUtil.instance.setHeight(12.0),),
              Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  color: Colors.white.withOpacity(0.5).withOpacity(0.5),
                  height: ScreenUtil.instance.setHeight(40),
                  width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(90),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text("Rice: ", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Text(country.toLowerCase() == "india" ? "Rs 35/Kilogram": "GHS 300/100Kg", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                      ],
                    ),
                  ),
                ),
                
              ),
            ),
            SizedBox(height: ScreenUtil.instance.setHeight(5.0),),
            Material(
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  height: ScreenUtil.instance.setHeight(40),
                  width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(90),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text("Maize:", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Text(country.toLowerCase() == "india" ? "Rs 70/Kilogram": "GHS 145/100Kg", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                      ],
                    ),
                  ),
                ),
                
              ),
            ),
            SizedBox(height: ScreenUtil.instance.setHeight(5.0),),
            // Material(
            //   child: InkWell(
            //     onTap: (){

            //     },
            //     child: Container(
            //       color: Colors.white.withOpacity(0.5),
            //       height: ScreenUtil.instance.setHeight(40),
            //       width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(90),
            //       child: Center(
            //         child: Row(
            //           children: <Widget>[
            //             Text("Wheat: ", style: TextStyle(fontFamily: "Roboto",
            // fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
            //             Spacer(),
            //             Text(country.toLowerCase() == "india" ? "Rs 1,840/100 kg": "GHS 288/100Kg", style: TextStyle(fontFamily: "Roboto",
            // fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
            //           ],
            //         ),
            //       ),
            //     ),
                
            //   ),
            // ),
          ],
        ),
            ],
          ),
        ), 
        Stack(
          children: <Widget>[
            Container(
              height: ScreenUtil.instance.setHeight(120),
              width: double.infinity,
            ),

          ],
        )
      ],
    );
  }


}