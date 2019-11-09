import 'dart:async';

import 'package:farmers_friend/src/screens/main/chat/widgets/chat_widget.dart';
import 'package:farmers_friend/src/screens/main/predictive_analysis/predictive_analysis_screen.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:farmers_friend/src/utility/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

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
                    Text("$_timeString", style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.instance.setSp(22.0), color: Color(getColorHexFromStr("#777a7b"))),),
                  ],
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(23.0),),
                // weatherForcastStackWidget(),
                CityTemperatureWidget(country: country,),
                SizedBox(height: ScreenUtil.instance.setHeight(30.0),),
                Text("Interactive Chatbot & Help Center", style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
                fontSize: ScreenUtil.instance.setSp(36.0), color: Colors.black),),
                SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                middleCardQuestionsColumn(),
                SizedBox(height: 10,),
              ],
            ),
          ),
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

  Widget middleCardQuestionsColumn(){
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil.instance.setHeight(150),
          decoration: BoxDecoration(
            color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.1),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(10.0), 
              vertical: ScreenUtil.instance.setHeight(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      // Material(
                      //   child: InkWell(
                      //     onTap: (){
                      //       Navigator.push(context, MaterialPageRoute(
                      //         builder: (BuildContext context){
                      //           return ChatWindow(plantName: "Maize Farming");
                      //         }
                      //       ));
                      //     },
                      //     child: Container(
                      //       height: ScreenUtil.instance.setHeight(120),
                      //       width: ScreenUtil.instance.setWidth(296),
                      //       child: Card(
                      //         color: Colors.white,
                      //         child: Padding(
                      //           padding: EdgeInsets.symmetric(
                      //             vertical: ScreenUtil.instance.setHeight(12),
                      //             horizontal: ScreenUtil.instance.setHeight(12),
                      //             ),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: <Widget>[
                      //               Text("Maize Farming", style: TextStyle(fontFamily: "PlayFair",
                      //               fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(28.0)),),
                      //               SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                      //               Text("Ask Questions",style: TextStyle(fontFamily: "Roboto",
                      //               fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                      //               color: Color(getColorHexFromStr("#36ab80"))),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                            
                      //     ),
                      //   ),
                      // ),
                      Material(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context){
                                return ChatWindow(plantName: "Rice Farming");
                              }
                            ));
                          },
                          child: Container(
                            height: ScreenUtil.instance.setHeight(120),
                            width: MediaQuery.of(context).size.width - 70,
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
                                    Text("Rice Farming", style: TextStyle(fontFamily: "PlayFair",
                                    fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(28.0)),),
                                    SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                                    Text("Ask Questions.",style: TextStyle(fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                                    color: Color(getColorHexFromStr("#36ab80"))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: ScreenUtil.instance.setHeight(7.0),),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   mainAxisSize: MainAxisSize.max,
                  //   children: <Widget>[
                  //     Material(
                  //       child: InkWell(
                  //         onTap: (){
                  //           Navigator.push(context, MaterialPageRoute(
                  //             builder: (BuildContext context){
                  //               return ChatWindow(plantName: "Tomato Farming");
                  //             }
                  //           ));
                  //         },
                  //         child: Container(
                  //           height: ScreenUtil.instance.setHeight(120),
                  //           width: ScreenUtil.instance.setWidth(296),
                  //           child: Card(
                  //             color: Colors.white,
                  //             child: Padding(
                  //               padding: EdgeInsets.symmetric(
                  //                 vertical: ScreenUtil.instance.setHeight(12),
                  //                 horizontal: ScreenUtil.instance.setHeight(12),
                  //                 ),
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: <Widget>[
                  //                   SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                  //                   Text("Tomato Farming", style: TextStyle(fontFamily: "PlayFair",
                  //                   fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(28.0)),),
                  //                   SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                  //                   Text("Ask Questions",style: TextStyle(fontFamily: "Roboto",
                  //                   fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                  //                   color: Color(getColorHexFromStr("#36ab80"))),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                            
                  //         ),
                  //       ),
                  //     ),
                  //     Material(
                  //       child: InkWell(
                  //         onTap: (){
                  //             Navigator.push(context, MaterialPageRoute(
                  //               builder: (BuildContext context){
                  //                 return ChatWindow(plantName: "Yam Farming");
                  //               }
                  //             ));
                  //           },
                  //         child: Container(
                  //           height: ScreenUtil.instance.setHeight(120),
                  //           width: ScreenUtil.instance.setWidth(296),
                  //           child: Card(
                  //             color: Colors.white,
                  //             child: Padding(
                  //               padding: EdgeInsets.symmetric(
                  //                 vertical: ScreenUtil.instance.setHeight(12),
                  //                 horizontal: ScreenUtil.instance.setHeight(12),
                  //                 ),
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: <Widget>[
                  //                   SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                  //                   Text("Yam Farming", style: TextStyle(fontFamily: "PlayFair",
                  //                   fontWeight: FontWeight.bold, fontSize: ScreenUtil.instance.setSp(28.0)),),
                  //                   SizedBox(height: ScreenUtil.instance.setHeight(8.0),),
                  //                   Text("Ask Questions",style: TextStyle(fontFamily: "Roboto",
                  //                   fontWeight: FontWeight.bold, height: 1.5, fontSize: ScreenUtil.instance.setSp(24.0),
                  //                   color: Color(getColorHexFromStr("#36ab80"))),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                    
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  
  
}

