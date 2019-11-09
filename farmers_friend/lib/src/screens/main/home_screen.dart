import 'package:farmers_friend/src/screens/main/camera/camera_screen.dart';
import 'package:farmers_friend/src/screens/main/infomation/info_and_quidelines.dart';
import 'package:farmers_friend/src/screens/main/infomation/start_planting_screen.dart';
import 'package:farmers_friend/src/screens/main/predictive_analysis/predictive_analysis_screen.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:farmers_friend/src/utility/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat/chat_screen.dart';
import 'pest_and_diseases/pest_and_diseases.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;
  final String _cropPref = "cropPref";

  bool cropNameEmpty = true;
  String country = "";
  String username = "";
  TextEditingController cropController = new TextEditingController();
  TextEditingController countryController;
  List<String> cropType = <String>["Maize", "Rice"];

  @override
    void initState(){
      super.initState();
      initializeDetails();
    }

  Future initializeDetails() async{
    String musername = await getNameFromPref();
    String mcountry = await getCountryFromPref();
    setState(() {
      username = musername;
      country = mcountry;
    });
    countryController = new TextEditingController(text: country);
  }

  @override
  Widget build(BuildContext context) {

    

    ScreenUtil.instance = ScreenUtil(
      width: 360, height: 360
    )..init(context);

    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(25.0),
            vertical: ScreenUtil.instance.setHeight(25.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                topRow(),
                SizedBox(height: ScreenUtil.instance.setHeight(5.0),),
                Container(
                  child: Divider(
                    color: Color(getColorHexFromStr("#bdc2c2")),
                  ),
                ),
                Text("What do you want to plant?", style: TextStyle(color: Colors.black, fontFamily: "Playfair", 
                fontSize: ScreenUtil.instance.setSp(16.0), fontWeight: FontWeight.bold), ),
                SizedBox(height: ScreenUtil.instance.setHeight(7.0),),
                middleTextFieldsColumn(),
                SizedBox(height: ScreenUtil.instance.setHeight(5.0),),
                bottomColumn()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget middleTextFieldsColumn(){
    return Column(
      children: <Widget>[
       // cropNameTextField(),
        cropTypeWidget(),
        SizedBox(height: ScreenUtil.instance.setHeight(6.0),),
        locationTextFieldRow(),
        SizedBox(height: ScreenUtil.instance.setHeight(6.0),),
        plantRaisedButton(),
        SizedBox(height: ScreenUtil.instance.setHeight(5.0),),
        Container(
          child: Divider(
            color: Color(getColorHexFromStr("#bdc2c2")),
          ),
        ),
      ],
    );
  }

  Widget bottomColumn(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Best crops to plant in October", style: TextStyle(color: Colors.black, fontFamily: "Playfair", 
          fontSize: ScreenUtil.instance.setSp(16.0), fontWeight: FontWeight.bold), ),
        SizedBox(height: ScreenUtil.instance.setHeight(5.0),),
        plantImageRow(),
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
            height: ScreenUtil.instance.setHeight(40),
            width: ScreenUtil.instance.setWidth(500),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: ScreenUtil.instance.setWidth(138),
                  height: ScreenUtil.instance.setHeight(20),
                  child: Image.asset(country == "Ghana"? "assets/images/tomatoes.png":
                  "assets/images/carrot_t.jpg", height: 30, fit: BoxFit.cover,),
                  
                ),
                SizedBox(width: 10,),
                Container(
                  width: ScreenUtil.instance.setWidth(138),
                  height: ScreenUtil.instance.setHeight(20),
                  child: Image.asset("assets/images/cabbage_t.jpg", height: 30, fit: BoxFit.cover,),
                  
                ),
                SizedBox(width: 10,),
                Container(
                  width: ScreenUtil.instance.setWidth(138),
                  height: ScreenUtil.instance.setHeight(20),
                  child: Image.asset(country == "Ghana"? "assets/images/garden_eggs_t.jpg"
                  :"assets/images/cauliflower_t.jpg", height: 30, fit: BoxFit.cover,),
                  
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget plantRaisedButton(){
    return Container(
      child: PhysicalModel(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Color(getColorHexFromStr("#36ab80")),
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: ScreenUtil.instance.setHeight(20.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            elevation: 3.0,
            disabledColor: Color(getColorHexFromStr("#bdc2c2")),
            color: Color(getColorHexFromStr("#36ab80")),
            onPressed: cropNameEmpty ? null: () async{
              await saveCropToPref(cropType[cropTypeValue - 1]);
              final BottomNavigationBar navigationBar = globalKey.currentWidget;
              navigationBar.onTap(1);
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (BuildContext context){
              //     return StartPlantingScreen(crop: cropType[cropTypeValue - 1]);
              //   }
              // ));
            },
            child: Text("Plant", style: TextStyle(color: Colors.white.withOpacity(0.8)),),
          ),
        ),
      ),
    );
  }

  Widget locationTextFieldRow(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        countryTextField(),
        // SizedBox(width: ScreenUtil.instance.setWidth(16.0),),
        // Flexible(
        //   child: cityTextField()
        //   )
      ],
    );
  }

  Widget cropNameTextField(){
    return Container(
      decoration: BoxDecoration(
        color: Color(getColorHexFromStr("#dedfe0")).withOpacity(0.15),
      ),
      child: TextField(
        controller: cropController,
        onChanged: (String value){
          if (value.isNotEmpty){
            setState(() {
              cropNameEmpty = false;
            });
          }
          else{
            setState(() {
              cropNameEmpty = true;
            });
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(5.0),
          vertical: ScreenUtil.instance.setHeight(6.0)),
          labelText: "Crop Name",
          labelStyle: TextStyle(color: Color(getColorHexFromStr("#bdc2c2")), 
          fontSize: ScreenUtil.instance.setSp(12)),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
          // ),
        ),      
      ),
    );
  }

  // Widget cityTextField(){
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Color(getColorHexFromStr("#dedfe0")).withOpacity(0.15),
  //     ),
  //     child: TextField(
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(5.0),
  //         vertical: ScreenUtil.instance.setHeight(6.0)),
  //         labelText: "City",
  //         labelStyle: TextStyle(color: Color(getColorHexFromStr("#bdc2c2")), 
  //         fontSize: ScreenUtil.instance.setSp(12)),
  //         // border: OutlineInputBorder(
  //         //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //         // ),
  //       ),      
  //     ),
  //   );
  // }

  Widget countryTextField(){
    return Container(
      decoration: BoxDecoration(
        color: Color(getColorHexFromStr("#dedfe0")).withOpacity(0.15),
      ),
      child: IgnorePointer(
        ignoring: true,
        child: TextField(
          controller: countryController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(5.0),
            vertical: ScreenUtil.instance.setHeight(6.0)),
            labelText: "Country",
            labelStyle: TextStyle(color: Color(getColorHexFromStr("#bdc2c2")), 
            fontSize: ScreenUtil.instance.setSp(12)),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
            // ),
          ),      
        ),
      ),
    );
  }

  int cropTypeValue;

  Widget cropTypeWidget(){
    return DropdownButton<int>(
      value: cropTypeValue,
      onChanged:(value){
        setState(() {
         cropTypeValue = value; 
         cropNameEmpty = false;
        });
      },
      items: <DropdownMenuItem<int>>[
        DropdownMenuItem(
          value: 1,
          child: Text(cropType[0], style: TextStyle(color: Colors.black, fontSize: ScreenUtil.instance.setSp(14.0))),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text(cropType[1], style: TextStyle(color: Colors.black, fontSize: ScreenUtil.instance.setSp(14.0))),
        ),
        
      ],
      hint: Text("Select Crop Type", style: TextStyle(color: Colors.black, fontSize: ScreenUtil.instance.setSp(12.0))),
      isExpanded: true,
    );
  }

  Widget topRow(){
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text("Hello $username", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
                fontFamily: "Playfair", fontSize: ScreenUtil.instance.setSp(20.0)),),
                SizedBox(width: 7.0,),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(5.0)),
                  child: Container(
                    height: 16,
                    width: 24,
                    child: Image.asset(country == "India" ? "assets/images/in.png": "assets/images/flag_ghana.png",),
                  ),
                ),
                
              ],
            ),
            
            SizedBox(height: ScreenUtil.instance.setHeight(5.0)),
            Text("$country", style: TextStyle(color: Color(getColorHexFromStr("#bdc2c2")), fontWeight: FontWeight.w500,
            fontFamily: "Roboto", fontSize: ScreenUtil.instance.setSp(10.0)),),
            SizedBox(height: ScreenUtil.instance.setHeight(5.0)),
            
          ],
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(""),
            // ),
          ),
        )
      ],
    );
  }
}

GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');


class BeforeHome extends StatefulWidget {
  @override
  _BeforeHomeState createState() => _BeforeHomeState();
}

class _BeforeHomeState extends State<BeforeHome> {

  
  int _currentIndex = 0;

  List<BottomNavigationBarItem> _bottomNavigationbarItem = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
      icon: Image.asset("assets/images/crops.png", height: 24, width: 19,),
      title: Text("", style: TextStyle(fontSize: 2.0),),
    ),
    new BottomNavigationBarItem(
      icon: Image.asset("assets/images/analysis.png", height: 24, width: 10,),
      title: Text("", style: TextStyle(fontSize: 2.0),),
    ),
    new BottomNavigationBarItem(
      icon: Image.asset("assets/images/pests.png", height: 20, width: 36,),
      title: Text("", style: TextStyle(fontSize: 2.0),),
    ),
    new BottomNavigationBarItem(
      icon: Image.asset("assets/images/chat.png", height: 24, width: 24,),
      title: Text("", style: TextStyle(fontSize: 2.0),),
    ),
    new BottomNavigationBarItem(
      icon: Image.asset("assets/images/payment.png", height: 24, width: 24,),
      title: Text("", style: TextStyle(fontSize: 2.0),),
    ),
  ];

  List<Widget> screens = <Widget>[
    HomeScreen(),
    StartPlantingScreen(),
    CameraScreen(),
    ChatScreen(),
    PredictiveAnalysisScreen(),
    
  ];

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(
      width: 720, height: 720
    )..init(context);


    return Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        key: globalKey,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: _currentIndex == 0 ? Image.asset("assets/images/plant_s.png", height: 24, width: 19,):
            Image.asset("assets/images/plant.png", height: 24, width: 19,),
            title: Text("", style: TextStyle(fontSize: 2.0),),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 1 ? Image.asset("assets/images/file_s.png", height: 24, width: 19,):
            Image.asset("assets/images/file.png", height: 24, width: 19,),
            title: Text("", style: TextStyle(fontSize: 2.0),),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 2 ? Image.asset("assets/images/camera_s.png", height: 24, width: 19,):
            Image.asset("assets/images/camera.png", height: 24, width: 19,),
            title: Text("", style: TextStyle(fontSize: 2.0),),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 3 ? Image.asset("assets/images/help_s.png", height: 24, width: 19,):
            Image.asset("assets/images/help.png", height: 24, width: 19,),
            title: Text("", style: TextStyle(fontSize: 2.0),),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 4 ? Image.asset("assets/images/analytics_s.png", height: 24, width: 19,):
            Image.asset("assets/images/analytics.png", height: 24, width: 19,),
            title: Text("", style: TextStyle(fontSize: 2.0),),
          ),
        ],
        elevation: 10,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        unselectedLabelStyle: TextStyle(color: Color(getColorHexFromStr("#d6d6df"))),
        showSelectedLabels: true,
        selectedItemColor: Color(getColorHexFromStr("#df0298")),
        unselectedItemColor: Color(getColorHexFromStr("#d6d6df")),
        selectedLabelStyle: TextStyle(color: Color(getColorHexFromStr("#df0298"))),
        selectedIconTheme: IconThemeData(color: Color(getColorHexFromStr("#df0298")),),
        unselectedIconTheme: IconThemeData(color: Color(getColorHexFromStr("#d6d6df"))),
        type: BottomNavigationBarType.fixed,
      ),
      body: 
        IndexedStack(
          index: _currentIndex,
          children: screens,

        )
    );
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}