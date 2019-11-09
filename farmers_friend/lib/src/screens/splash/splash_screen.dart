import 'dart:async';
import 'dart:convert';

import 'package:farmers_friend/src/screens/Login/login_screen.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String walkthroughCount = "onBoardingScreenCount";
  bool isUserOnboarded;
  Map<String, dynamic> _userDetails;
//   Animatable<Color> background = TweenSequence<Color>(
//   [
//     // TweenSequenceItem(
//     //   weight: 1.0,
//     //   tween: ColorTween(
//     //     begin: Color(getColorHexFromStr("#5b1060")),
//     //     end: appTheme.primaryColor,
//     //   ),
//     // ),
//     // TweenSequenceItem(
//     //   weight: 1.0,
//     //   tween: ColorTween(
//     //     begin: Colors.green,
//     //     end: Colors.blue,
//     //   ),
//     // ),
//     // TweenSequenceItem(
//     //   weight: 1.0,
//     //   tween: ColorTween(
//     //     begin: Colors.blue,
//     //     end: Colors.pink,
//     //   ),
//     // ),
//   ],
// );

  @override
  void initState() {
    super.initState();
   // removeOnboardingCount(walkthroughCount);
    // _gradientBGController = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 5)
    // )..repeat();
    Timer(Duration(seconds: 5), () { 
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context){
          return LoginScreen();
        }
      ));
      LoginScreen();}
      ); // _navigateToNextScreen());
  }

  /// Navigates to Onboarding Screen if its the first time or Login Screen if the user
  /// never logged in or return logged in screen... if the user has closed the app
  // void _navigateToNextScreen() async{
  // isUserOnboarded = await getOnboardingOff();
  //   if (isUserOnboarded == false || isUserOnboarded == null){
  //     Navigator.pushReplacement(context, SlideRightRoute(
  //     page: OnboardScreenNotifier(),
  //   ));
  //   }
  //   else{
  //     String email = await getEmailToVerifySession();
  //     String userDetailsString = await getUserDetails();
  //     if (userDetailsString != null){
  //       Navigator.pushReplacement(context, MaterialPageRoute(
  //         builder: (BuildContext context){
  //           return ReturningLoginScreen();
  //         }
  //       ));
  //       return;
  //     }
  //     else if (email == null){
  //       Navigator.pushReplacement(context, MaterialPageRoute(
  //         builder: (BuildContext context){
  //           return LoginScreen();
  //           }
  //         ));
  //         return;
  //       }
  //     Navigator.pushReplacement(context, MaterialPageRoute(
  //         builder: (BuildContext context){
  //           return LoginScreen();
  //           }
  //         )); 
        
  //     }
  // }

  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/omni_ai_logo.png")
                              )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          // Text("Waya", style: TextStyle(color: Colors.white, fontSize: 24.0, 
                          // fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Container(
                        //   height: 30.0,
                        //   width: 30.0,
                        //   child: CircularProgressIndicator(
                        //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        Center(
                          child: Container(
                            height: 15,
                            width: 140,
                            child: Image.asset("assets/images/limitless_ai.png", fit: BoxFit.fill,),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
        );
  }
}