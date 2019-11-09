import 'dart:async';

import 'package:farmers_friend/src/screens/main/predictive_analysis/predictive_analysis_screen.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:farmers_friend/src/utility/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../home_screen.dart';


class MyData{
  String _title, _body;
  bool isExpanded;

  MyData(this._title, this._body, this.isExpanded);

  @override
  String toString() {

    return "MyData{title: $title, body: $body, expanded: $isExpanded}";
  }

  bool get expanded => isExpanded;

  String get title => this.title;

  String get body => this.body;

  set expanded(bool value){
    isExpanded = value;
  }


  set title(String value){
    _title = value;
  }

  set body(String value){
    _body = value;
  }

}


class PestAndDiseasesScreen extends StatefulWidget {
  @override
  _PestAndDiseasesScreenState createState() => _PestAndDiseasesScreenState();
}

class _PestAndDiseasesScreenState extends State<PestAndDiseasesScreen> {

  List<MyData> _list = <MyData>[];
  int currentIndex = 0;
  String country = "";
  String username = "";
  List<ExpansionPanel> mylist = <ExpansionPanel>[];

  void _onExpansion(int index, bool expanded){
    setState(() {
    _list[index].expanded = !_list[index].expanded;
    });
  }

  List<ExpansionPanel> buildExpandedWidgets(){
    List<ExpansionPanel> mlist = <ExpansionPanel>[];
    for (int i = 0, ii = _list.length; i < ii; i++){
      var expansionData = _list[i];
      mlist.add(ExpansionPanel(headerBuilder: (BuildContext context, bool isExpanded){
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(expansionData.title, style: TextStyle(fontFamily: "Roboto", fontSize: 16.0,
          fontWeight: FontWeight.w500),),
        );
      },
      body: Text(expansionData.title, style: TextStyle(fontFamily: "Roboto", fontSize: 16.0,
          fontWeight: FontWeight.w500),),
      isExpanded: expansionData.isExpanded,
      )
      );
    }
    setState(() {
      mylist = mlist;
    });
    return mylist;
  }
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
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
  }

  Future initializeDetails() async{
    String musername = await getNameFromPref();
    String mcountry = await getCountryFromPref();
    setState(() {
      username = musername;
      country = mcountry;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 720, height: 720
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
                    Text("_$_timeString", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.instance.setSp(22.0), color: Color(getColorHexFromStr("#777a7b"))),),
                  ],
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(23.0),),
                // weatherForcastStackWidget(),
                CityTemperatureWidget(country: country,),
                SizedBox(height: ScreenUtil.instance.setHeight(15.0),),
                Text("Best crops to plant in October", style: TextStyle(color: Colors.black, fontFamily: "Playfair", 
              fontSize: ScreenUtil.instance.setSp(34.0), fontWeight: FontWeight.bold), ),
                SizedBox(height: ScreenUtil.instance.setHeight(11.0),),
                plantImageRow(),
                SizedBox(height: ScreenUtil.instance.setHeight(5.0),),
                Container(
                  child: Divider(),
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                // Text("Farmers Friend wants you to know:",  style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w400,
                // fontSize: ScreenUtil.instance.setSp(26.0), color: Color(getColorHexFromStr("#777a7b"))),),
                // SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                middlePestAndDiseaseColumn(),
                // middleCardDetailsColumn(),
                
                
              ],
            ),
          ),
          SizedBox(height: ScreenUtil.instance.setHeight(15.0),),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Material(
          //       child: InkWell(
          //         // child: Container(
          //         //   height: 40,
          //         //   width: 130,

          //         // ),
          //       )
          //     ),
          //     // Expanded(
          //     //   child: Container(
          //     //     height: 300,
          //     //     child: ExpansionPanelList(
          //     //       children: mylist,
          //     //       expansionCallback: _onExpansion,
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),
          bottomChartColumnWidget(context),
          SizedBox(height: 20,),
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  height:70,
                  width:70,
                  child: Image.asset("assets/images/omni_ai_logo.png", fit: BoxFit.cover),
                ),
                // Text("Welcome Back", style: TextStyle(color: Colors.black, fontFamily: "Playfair",
                // fontSize: ScreenUtil.instance.setSp(20), fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Container(
                  height: 44,
                  width: 130,
                  child: RaisedButton(
                    color: Color(getColorHexFromStr("#36ab80")),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.key, size: 14, color: Colors.white.withOpacity(0.8),),
                        SizedBox(width: 5.0,),
                        Text("Unlock", style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8))),
                      ],
                    ),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (BuildContext context){
                          return BeforeHome();
                        }
                      ));
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
      
    );
  }

  Widget middlePestAndDiseaseColumn(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Pest Alert", style: TextStyle(color: Colors.black, fontFamily: "Playfair", 
              fontSize: ScreenUtil.instance.setSp(34.0), fontWeight: FontWeight.bold), ),
        SizedBox(height: ScreenUtil.instance.setHeight(11.0),),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  color: Colors.white.withOpacity(0.5).withOpacity(0.5),
                  height: ScreenUtil.instance.setHeight(30),
                  width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(90),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/images/stem_borer.jpg",),
                        ),
                        SizedBox(width: 10.0,),
                        Text(country.toLowerCase() == "India".toLowerCase()? "Stemborers": "Fall Armyworm", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(30), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 18, color: Color(getColorHexFromStr("#c9ced6")),)
                      ],
                    ),
                  ),
                ),
                
              ),
            ),
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
                        Container(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/images/fall_army_worm.jpg",),
                        ),
                        SizedBox(width: 10.0,),
                        Text(country.toLowerCase() == "India".toLowerCase() ? "Fall Armyworm": "Locust",
                         style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(30), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 18, color: Color(getColorHexFromStr("#c9ced6")),)
                      ],
                    ),
                  ),
                ),
                
              ),
            ),
          ],
        ),
        Container(
          child: Divider(

          ),
        ),
        SizedBox(height: 15,),
        // Disease Section
        Text("Disease Alert", style: TextStyle(color: Colors.black, fontFamily: "Playfair", 
              fontSize: ScreenUtil.instance.setSp(34.0), fontWeight: FontWeight.bold), ),
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
                        Text(country.toLowerCase() == "india" ? "Blight": "Black Pod disease", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 18, color: Color(getColorHexFromStr("#c9ced6")),)
                      ],
                    ),
                  ),
                ),
                
              ),
            ),
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
                        Text(country.toLowerCase() == "india" ? "Smut": "Swollen shoot disease", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 18, color: Color(getColorHexFromStr("#c9ced6")),)
                      ],
                    ),
                  ),
                ),
                
              ),
            ),
          ],
        ),
        Container(
          child: Divider(

          ),
        ),
        // Best Plant to plant this year section
         SizedBox(height: 10,),

        // Text("Best Crops To Plant This Year", style: TextStyle(color: Colors.black, fontFamily: "Playfair", 
        //       fontSize: ScreenUtil.instance.setSp(34.0), fontWeight: FontWeight.bold), ),
        // Column(
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         SizedBox(height: ScreenUtil.instance.setHeight(15),),
        //          Text("Maize", style: TextStyle(fontFamily: "Roboto",
        //     fontSize: ScreenUtil.instance.setSp(24), color: Color(getColorHexFromStr("#777a7b")))),
        //     SizedBox(height: ScreenUtil.instance.setHeight(12),),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             LinearPercentIndicator(
        //             width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(160),
        //             lineHeight: ScreenUtil.instance.setHeight(10.0),
        //             percent: 0.7,
        //             backgroundColor: Color(getColorHexFromStr("#eaeaea")).withOpacity(0.8),
        //             progressColor: Color(getColorHexFromStr("#36ab80")),
        //       ),
        //       Spacer(),
        //        Text("70%", style: TextStyle(fontFamily: "Roboto",
        //     fontSize: ScreenUtil.instance.setSp(18), color: Color(getColorHexFromStr("#777a7b")))),
        //           ],
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: ScreenUtil.instance.setHeight(12),),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         SizedBox(height: ScreenUtil.instance.setHeight(15),),
        //          Text("Cassava", style: TextStyle(fontFamily: "Roboto",
        //     fontSize: ScreenUtil.instance.setSp(24), color: Color(getColorHexFromStr("#777a7b")))),
        //     SizedBox(height: ScreenUtil.instance.setHeight(12),),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             LinearPercentIndicator(
        //             width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(160),
        //             lineHeight: ScreenUtil.instance.setHeight(10.0),
        //             percent: 0.4,
        //             backgroundColor: Color(getColorHexFromStr("#eaeaea")).withOpacity(0.8),
        //             progressColor: Color(getColorHexFromStr("#36ab80")),
        //       ),
        //       Spacer(),
        //        Text("40%", style: TextStyle(fontFamily: "Roboto",
        //     fontSize: ScreenUtil.instance.setSp(18), color: Color(getColorHexFromStr("#777a7b")))),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget weatherForcastStackWidget(){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(80),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            elevation: 10.0,
            child: Image.asset("assets/images/forcast_bg.png", fit: BoxFit.fill,),
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

  Widget plantImageRow(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Container(
            height: ScreenUtil.instance.setHeight(70),
            width: ScreenUtil.instance.setWidth(600),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: ScreenUtil.instance.setWidth(250),
                  height: ScreenUtil.instance.setHeight(100),
                  child: Image.asset("assets/images/tomatoes.png", height: 80, fit: BoxFit.cover),
                  
                ),
                SizedBox(width: 10,),
                Container(
                  width: ScreenUtil.instance.setWidth(250),
                  height: ScreenUtil.instance.setHeight(100),
                  child: Image.asset("assets/images/maize.png", height: ScreenUtil.instance.setHeight(80),
                  fit: BoxFit.cover,),
                  
                ),
                SizedBox(width: 10,),
                Container(
                  width: ScreenUtil.instance.setWidth(250),
                  height: ScreenUtil.instance.setHeight(80),
                  child: Image.asset("assets/images/tomatoes.png", height: 80, fit: BoxFit.cover),
                  
                ),
              ],
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
            color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.1),
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
                                child: Image.asset("assets/images/yellow_cloud.png", height: 30, width: 30,
                                alignment: Alignment.topLeft,),
                              ),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Text("Weather Forecast", style: TextStyle(fontFamily: "PlayFair",
                              fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(28.0)),),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Text("Sunny with 20%\nchance of rain",style: TextStyle(fontFamily: "Roboto",
                              fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                              color: Color(getColorHexFromStr("#777a7b"))),
                              ),
                            ],
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
                              fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
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
                                      style: TextStyle(fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: "Aphids",
                                      style: TextStyle(fontFamily: "Roboto",
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Colors.black)
                                      ),
                                      TextSpan(
                                      text: ", ",
                                      style: TextStyle(fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: "Worms ",
                                      style: TextStyle(fontFamily: "Roboto", decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Colors.black)
                                      ),
                                      TextSpan(
                                      text: "and ",
                                      style: TextStyle(fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: "Weevils.",
                                      style: TextStyle(fontFamily: "Roboto", decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Colors.black)
                                      ),
                                  ]
                                ),
                              ),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Text("Learn More", style: TextStyle(fontFamily: "Roboto", color: Color(getColorHexFromStr("#36ab80")),
                              fontWeight: FontWeight.w500, fontSize: ScreenUtil.instance.setSp(24.0)),),
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
                                      style: TextStyle(fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: "Aphids",
                                      style: TextStyle(fontFamily: "Roboto",
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Colors.black)
                                      ),
                                      TextSpan(
                                      text: ", ",
                                      style: TextStyle(fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: "Worms ",
                                      style: TextStyle(fontFamily: "Roboto", decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Colors.black)
                                      ),
                                      TextSpan(
                                      text: "and ",
                                      style: TextStyle(fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Color(getColorHexFromStr("#777a7b")))
                                      ),
                                      TextSpan(
                                      text: "Weevils.",
                                      style: TextStyle(fontFamily: "Roboto", decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                      color: Colors.black)
                                      ),
                                  ]
                                ),
                              ),
                              SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                              Text("Learn More", style: TextStyle(fontFamily: "Roboto", color: Color(getColorHexFromStr("#36ab80")),
                              fontWeight: FontWeight.w500, fontSize: ScreenUtil.instance.setSp(24.0)),),
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
                        Text("Wheat: ", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Text(country.toLowerCase() == "india" ? "Rs 1,840/100 kg": "GHS 288/100Kg", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                      ],
                    ),
                  ),
                ),
                
              ),
            ),
          ],
        ),
              SizedBox(height: ScreenUtil.instance.setHeight(6.0),),
            ],
          ),
        ), 
        // Stack(
        //   children: <Widget>[
        //     Container(
        //       height: ScreenUtil.instance.setHeight(120),
        //       width: double.infinity,
        //     ),
        //     Positioned(
        //       bottom: 0.0,
        //       left: 0.0,
        //       right: 0.0,
        //       child: dummyChart(context))
        //       ,
        //   ],
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setHeight(25.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: ScreenUtil.instance.setHeight(11.0),),
              Container(
                child: Divider(),
              ),
              SizedBox(height: ScreenUtil.instance.setHeight(11.0),),
              Text("Agri Input Products", style: TextStyle(fontFamily: "PlayFair",
                  fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(34.0)),),
              SizedBox(height: ScreenUtil.instance.setHeight(27.0),),
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
                        Text("Pesticides: ", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Text(country.toLowerCase() == "india" ? "Rs 400/ Litre": "GHS 80/ 1Litre container", style: TextStyle(fontFamily: "Roboto",
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
                        Text("Fertilizer:", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Text(country.toLowerCase() == "india" ? "Rs 278.51/ 50Kg bag": "GHS 75/ 50Kg bag", style: TextStyle(fontFamily: "Roboto",
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
                        Text("Weedicides: ", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                        Spacer(),
                        Text(country.toLowerCase() == "india" ? "Rs 400/ Litre": "GHS 65/ 1Litre container", style: TextStyle(fontFamily: "Roboto",
            fontSize: ScreenUtil.instance.setSp(26), color: Color(getColorHexFromStr("#777a7b")))),
                      ],
                    ),
                  ),
                ),
                
              ),
            ),
          ],
        ),
            ],
          ),
        ),
      ],
    );
  }

//   Widget dummyChart(BuildContext context) {
//   final fromDate = DateTime(2019, 05, 22);
//   final toDate = DateTime.now();

//   final date1 = DateTime.now().subtract(Duration(days: 2));
//   final date2 = DateTime.now().subtract(Duration(days: 3));

//   return Center(
//     child: Container(
//       height: ScreenUtil.instance.setHeight(120),
//       width: MediaQuery.of(context).size.width,
//       // child: BezierChart(
//       //   fromDate: fromDate,
//       //   bezierChartScale: BezierChartScale.WEEKLY,
//       //   toDate: toDate,
//       //   selectedDate: toDate,
//       //   series: [
//       //     BezierLine(
//       //       label: "Duty",
//       //       onMissingValue: (dateTime) {
//       //         if (dateTime.day.isEven) {
//       //           return 10.0;
//       //         }
//       //         return 5.0;
//       //       },
//       //       data: [
//       //         DataPoint<DateTime>(value: 10, xAxis: date1),
//       //         DataPoint<DateTime>(value: 50, xAxis: date2),
//       //       ],
//       //     ),
//       //   ],
//       //   config: BezierChartConfig(
//       //     pinchZoom: true,
//       //     xAxisTextStyle: TextStyle(color: Colors.black, fontFamily: "Roboto", 
//       //     fontSize: ScreenUtil.instance.setSp(22.0)),
//       //     verticalIndicatorStrokeWidth: 3.0,
//       //     verticalIndicatorColor: Colors.black26,
//       //     showVerticalIndicator: true,
//       //     verticalIndicatorFixedPosition: false,
//       //     backgroundGradient: LinearGradient(
//       //       begin: Alignment.topCenter,
//       //       end: Alignment.bottomCenter,
//       //       colors: <Color>[
//       //         Color(getColorHexFromStr("#36ab80")),
//       //         Color(getColorHexFromStr("#f3f5f6")),
//       //       ]
//       //     ),
//       //     footerHeight: 30.0,
//       //   ),
//       // ),
//     ),
//   );
// }


}