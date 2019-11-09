import 'package:after_layout/after_layout.dart';
import 'package:farmers_friend/src/provider/crop_model.dart';
import 'package:farmers_friend/src/screens/main/infomation/crop_detail_page.dart';
import 'package:farmers_friend/src/screens/main/infomation/info_and_quidelines.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:farmers_friend/src/utility/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';



class StartPlantingScreen extends StatefulWidget {
  final String crop;
  StartPlantingScreen({this.crop});
  @override
  _StartPlantingScreenState createState() => _StartPlantingScreenState();
}

class _StartPlantingScreenState extends State<StartPlantingScreen> with AfterLayoutMixin<StartPlantingScreen> {
  String country = "";
  String username = "";
  TextEditingController cropController = new TextEditingController();
  TextEditingController countryController;

  CropModel cropModel = new CropModel();

  @override
  void afterFirstLayout(BuildContext context) async{
    await cropModel.getCrop();
  }

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
      width: 720, height: 720
    )..init(context);

    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: ScopedModelDescendant<CropModel>(
          builder: (context, child, model)=> Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            height: 44,
            width: 150,
            child: new FloatingActionButton(
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
            elevation: model.crop == null ? 0.0: 5.0,
            child: Row(
              children: <Widget>[
                SizedBox(width: ScreenUtil.instance.setWidth(10)),
                new Image.asset("assets/images/crops.png", height: 24, width: 24,
                 ),
                 SizedBox(width: ScreenUtil.instance.setWidth(10)),
                 Text("Start Planting", style: TextStyle(fontSize: 12, fontFamily: "Roboto", color: Colors.white)),
              ],
            ),
            backgroundColor: model.crop == null ? Color(getColorHexFromStr("#777a7b")).withOpacity(0.3): Color(getColorHexFromStr("#36ab80")),
            onPressed: model.crop == null ? null: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (BuildContext context){
                    return InformationAndGuidelinesScreen(
                     crop: model.crop,
                     country: model.country,
                    );
                  }
                )
              );
            }
    ),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              topVideoRow(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(25.0)),
                child:  ScopedModelDescendant<CropModel>(
                builder: (context, child, model){
                  model.getCrop();
                  if (model.crop == "Maize" && model.country == "India"){
                    return indiaMaizeSearchResults();
                  }
                  else if (model.crop == "Maize" && model.country == "Ghana"){
                    return ghanaMaizeSearchResults();
                  }
                  else if (model.crop == "Rice" && model.country == "Ghana"){
                    return ghanaRiceSearchResults();
                  }
                  else if (model.crop == "Rice" && model.country == "India"){
                    return indiaRiceSearchResults();
                  }
                  else{
                    return Padding(
                      padding: const EdgeInsets.only(top: 58.0),
                      child: Container(
                        child: Center(
                          child: Text("No Crop Selected", style: TextStyle(fontSize: 26, fontFamily: "Oxygen",
                          fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.3)))
                        ),
                      ),
                    );
                  }
                } 
                ), // indiaMaizeSearchResults(),
              ),
              
            ],
          ),
        ],
      )
      
    );
  }



  Widget indiaMaizeSearchResults(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Rainfall pattern for Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width:  MediaQuery.of(context).size.width -  ScreenUtil.instance.setWidth(60),
          height: ScreenUtil.instance.setHeight(250),
          child: Image.asset("assets/images/graph.png", fit: BoxFit.cover),
        ),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Average amount of rainfall in mm for Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("The average monsoon rainfall for Hyderabad is 100 millimetres (3.9 in).", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Average regional climate for Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Hyderabad has a unique combination of a tropical wet and dry climate that borders on a hot semi-arid climate (Köppen climate classification BSh). The climate of Hyderabad remains fairly warm through most parts of the year and does not receive much rainfall in the monsoon. ", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Specific natural disasters that affect Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Drought", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Mudslides", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Frequency of the above Natural disasters in Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods occur July to September", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Droughts occur in January to April", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods occur July to September", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("General soil type in Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Red Sandy soil", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best propagation or farming methods for maize in Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Hand Planting", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Mechanical planting", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("This type of planting has the advantage of being quick, and if well supervised will give excellent results. However, if it is poorly supervised, it will give poor-to-disastrous results. It allows you to plant a large acreage within your pre-determined planting period. Adapt a spacing compatible with other mechanical operations like fertilizer application and weeding. Check the machine well before the anticipated planting date to make proper adjustment. Always read the operator's manual and seek advice from the suppliers for effective usage. Every season, make sure that the planter is calibrated to avoid making costly mistakes.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b")) ),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Below are some guidelines for calibration:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Each planter must be tested separately.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Select plates that will allow the largest seed of your seed sample to go through. Make sure the plate does not allow two seeds at a time.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Make sure that the driving wheel drops seeds in the furrow opener.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Count the number of seeds dropped by the planter over a measured length in the field at a set driving speed. The number can be multiplied to get total number dropped / ha. The correct operating speed is normally indicated in the operator's manual e.g. 5 km/h.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historical planting time for maize in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Major Season: July through to October  ", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Minor Season: December through to February", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Below are some guidelines for calibration:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Each planter must be tested separately.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Select plates that will allow the largest seed of your seed sample to go through. Make sure the plate does not allow two seeds at a time.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Make sure that the driving wheel drops seeds in the furrow opener.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Count the number of seeds dropped by the planter over a measured length in the field at a set driving speed. The number can be multiplied to get total number dropped / ha. The correct operating speed is normally indicated in the operator's manual e.g. 5 km/h.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best planting time for maize in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• July", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historical Harvesting time for maize in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• November", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best Harvesting time for maize in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• October", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),




        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two natural fertilizer options for maize in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Cow dung", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Chicken manure", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),



        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Common Maize crop disease to expect during the farming season in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Maize Streak", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Northern leaf blight", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),

          SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Common Maize crop pests to expect during the farming season in India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Fall Armyworms", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Lesser Grain Weevils (storage pest)", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),



         SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top three Maize crop pests to expect during the farming season in India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Fall Armyworms", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Termites", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Lesser Grain Weevils (storage pest)", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),


        
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two chemical fertilizer options for maize in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("In general, rates of applications per hectare in India average around 90 kg N. 60 kg P2O5 and 60 kg K2O. However, fertilizer N levels up to 120 kg/ha are recommended for cultivation in degraded soils.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),




        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best soil type for maize in India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Well-drained, well-aerated, deep warm loams and silt loams containing adequate organic matter and well supplied with available nutrients.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Agric policy in direct relation to Maize in in India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Agricultural policy of India is generally designed by the Government to raise agricultural production and productivity and also to upgrade the level of income and standard of living of farmers within a definite time frame.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("This includes measures such:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        


              ],
    );
  }


  Widget indiaRiceSearchResults(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Rainfall pattern for Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width:  MediaQuery.of(context).size.width -  ScreenUtil.instance.setWidth(60),
          height: ScreenUtil.instance.setHeight(250),
          child: Image.asset("assets/images/graph.png", fit: BoxFit.cover),
        ),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Average amount of rainfall in mm for Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("The average monsoon rainfall for Hyderabad is 100 millimetres (3.9 in).", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Average regional climate for Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Hyderabad has a unique combination of a tropical wet and dry climate that borders on a hot semi-arid climate (Köppen climate classification BSh). The climate of Hyderabad remains fairly warm through most parts of the year and does not receive much rainfall in the monsoon. ", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Specific natural disasters that affect Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Drought", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Mudslides", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Frequency of the above Natural disasters in Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods occur July to September", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Droughts occur in January to April", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods occur July to September", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("General soil type in Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Red Sandy soil", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best propagation or farming methods for rice in Hyderabad, India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Broadcasting method:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Seeds are sown broadcast by hand. This method is practised in those areas which are comparatively dry and less fertile and do not have much labour to work in the fields. It is the easiest method requiring minimum input but its yields are also minimum.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Drilling method:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Ploughing of land and sowing of seeds is done by two persons. This method is mostly confined to peninsular India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b")) ),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Transplantation method:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("This method is practiced in areas of fertile soil, abundant rainfall and plentiful supply of labour. To begin with, seeds are sown in nursery and seedlings are prepared. After 4-5 weeks the seedlings are uprooted and planted in the field which has already been prepared for the purpose. The entire process is done by hand. It is, therefore, a very difficult method and requires heavy inputs. But at the same time it gives some of the highest yields.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b")) ),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Japanese method:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("This method includes the use of high yielding varieties of seeds, sowing the seeds in a raised nursery-bed and transplanting the seedlings in rows so as to make weeding and fertilizing easy. It also involves the use of a heavy dose of fertilizers so that very high yields are obtained. The Japanese method of rice cultivation has been successfully adopted in the main rice producing regions of India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b")) ),textAlign: TextAlign.justify,
          ),
        ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("Below are some guidelines for calibration:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        //   Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Each planter must be tested separately.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
          
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Select plates that will allow the largest seed of your seed sample to go through. Make sure the plate does not allow two seeds at a time.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Make sure that the driving wheel drops seeds in the furrow opener.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Count the number of seeds dropped by the planter over a measured length in the field at a set driving speed. The number can be multiplied to get total number dropped / ha. The correct operating speed is normally indicated in the operator's manual e.g. 5 km/h.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historical planting time for rice in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Major Season: May through to July  ", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Minor Season: November to December", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("Below are some guidelines for calibration:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        //   Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Each planter must be tested separately.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
          
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Select plates that will allow the largest seed of your seed sample to go through. Make sure the plate does not allow two seeds at a time.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Make sure that the driving wheel drops seeds in the furrow opener.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Count the number of seeds dropped by the planter over a measured length in the field at a set driving speed. The number can be multiplied to get total number dropped / ha. The correct operating speed is normally indicated in the operator's manual e.g. 5 km/h.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
         SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best planting time for rice in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• June", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historical Harvesting time for rice in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• September throught to November", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best Harvesting time for rice in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• September", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),




        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two natural fertilizer options for maize in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Cow dung", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Chicken manure", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),



        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Common rice crop disease to expect during the farming season in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Rice Streak", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Northern leaf blight", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),

          SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Common rice crop pests to expect during the farming season in India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Stem borers", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Leaf worm", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),



         SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top three rice crop pests to expect during the farming season in India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Yellow Stem borers", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Rice gall midge", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        

        
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two chemical fertilizer options for maize in India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("In general, rates of applications per hectare in India average around 90 kg N. 60 kg P2O5 and 60 kg K2O. However, fertilizer N levels up to 120 kg/ha are recommended for cultivation in degraded soils.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),




        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best soil type for maize in India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Clayey loam soil", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Agric policy in direct relation to Maize in in India", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Agricultural policy of India is generally designed by the Government to raise agricultural production and productivity and also to upgrade the level of income and standard of living of farmers within a definite time frame.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("This includes measures such:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Afforestation and to utilize barren land.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Encouraging multi-cropping and inter-cropping.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Supporting farmers and laborers financially and granting them entitlement to trees and pastures.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        


              ],
    );
  }






  Widget ghanaMaizeSearchResults(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Rainfall pattern for Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width:  MediaQuery.of(context).size.width -  ScreenUtil.instance.setWidth(60),
          height: ScreenUtil.instance.setHeight(250),
          child: Image.asset("assets/images/graph.png", fit: BoxFit.cover),
        ),
        Container(
          
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Average amount of rainfall in mm for Northern Region, Ghana", style: TextStyle(height: 1.2, fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• 78 to 216 centimeters (31 to 85 inches) a year", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Average regional climate for Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("""The climate of the region is relatively dry, with a single rainy season that begins in May and ends in October. The amount of rainfall recorded annually varies between 750 mm and 1050 mm. The dry season starts in November and ends in March/April with maximum temperatures occurring towards the end of the dry season (March-April) and minimum temperatures in
The main vegetation is classified as vast areas of grassland, interspersed with the guinea savannah woodland, characterized by drought-resistant trees such as the acacia, baobab, shea nut, dawadawa, mango, neem
          """, style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Specific natural disasters that affect Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Drought", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Bush Fires", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Frequency of the above Natural disasters in Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Bush fires in November and December when drought occurs", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Droughts occur in September and October when they do", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods occur July and in November", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("General soil type in Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Predominantly light textured surface horizons in which sandy loams and loams.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best propagation or farming methods for maize in Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Hand Planting", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("""A measuring tape is used to mark 25cm/40cm depending on maize variety along a measuring line for the distances between the seeds. A second measuring line is measured at a distance of 75cm/80cm/90cm between rows depending on maize variety. 
A planting stick is used to make two holes at the same time, one at a depth of 5cm for seed and the other at a depth of 10cm for an application of 10g of fertilizer.
Place the seed and make the final covering. Make sure that the seed is well holed in to ensure good contact with moisture. All seeds must be well covered.
          """, style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Mechanical planting", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("""This type of planting has the advantage of being quick, and if well supervised will give excellent results. However, if it is poorly supervised, it will give poor-to-disastrous results. It allows you to plant a large acreage within your pre-determined planting period. Adapt a spacing compatible with other mechanical operations like fertilizer application and weeding. Check the machine well before the anticipated planting date to make proper adjustment. Always read the operator's manual and seek advice from the suppliers for effective usage. Every season, make sure that the planter is calibrated to avoid making costly mistakes.
          """, style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Below are some guidelines for calibration:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Each planter must be tested separately.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Select plates that will allow the largest seed of your seed sample to go through. Make sure the plate does not allow two seeds at a time.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Make sure that the driving wheel drops seeds in the furrow opener.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Count the number of seeds dropped by the planter over a measured length in the field at a set driving speed. The number can be multiplied to get total number dropped / ha. The correct operating speed is normally indicated in the operator's manual e.g. 5 km/h.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historical planting time for maize in Northern Region, GHANA.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Major Season: May through the third week of May", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Minor Season: The third week of August to end of September.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        
         SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best planting time for maize in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• July through early August ", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historical Harvesting time for maize in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• August", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best Harvesting time for maize in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• September", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),




        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two natural fertilizer options for maize in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Cow dung", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Chicken manure", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),



        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Common Maize crop disease to expect during the farming season in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Maize Streak", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Northern leaf blight", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),

          SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Common Maize crop pests to expect during the farming season in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Fall Armyworms", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Lesser Grain Weevils (storage pest)", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),



         SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top three Maize crop pests to expect during the farming season in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Fall Armyworms", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Termites", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Lesser Grain Weevils (storage pest)", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),


        
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two chemical fertilizer options for maize in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("In general, rates of applications per hectare in Ghana average around 90 kg N. 60 kg P2O5 and 60 kg K2O. However, fertilizer N levels up to 120 kg/ha are recommended for cultivation in degraded soils.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),




        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best soil type for maize in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Well-drained, well-aerated, deep warm loams and silt loams containing adequate organic matter and well supplied with available nutrients.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Agric policy in direct relation to Maize in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Government intends to construct a 1, 000 metric tonne capacity warehouse in each district to provide handling and storage space for the surpluses which are anticipated. In order for the surpluses not to stay in the warehouses for long and to encourage the consumption of local food, the Ministry of Food and Agriculture will enter into agreements with the Ministries of Gender, Education and Health to purchase foodstuffs for the School Feeding Programme, for colleges, hospitals and other state institutions.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Type of government subsidy for maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("""For the compound fertilizer of 50kg/ha, out of the full cost of Gh¢115.00 government subsidy amounts to Gh¢26.00 thus pegging the selling price at Gh¢89.00, representing 26% in price reduction while for Urea, government subsidy on 50kg/ha costing Gh¢105.00 was Gh¢21.00, representing a 20% of subsidy. 
The market prices for both the compound fertilizer and the urea were Gh¢89.00 per 50kg bag and Gh¢84.00 per 50 kg bag, respectively. By these price reductions, it is estimated that government is subsidizing fertilizer at an average of 21%.""", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Lowest Market price over the past three years for Maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("GHS 96 for a Bag of maize", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Highest Market price over the past three years for Maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("GHS 115 for a Bag of maize", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),


        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best Market price over the past two years for Maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("GHS 175 for a Bag of maize", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          
        
         SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historically best month to sell harvested maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• May", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• August", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: ScreenUtil.instance.setHeight(20)),
    
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two areas of demand for maize from Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Accra", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Kumasi", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Takoradi", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top countries of demand for maize from Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• IvoryCoast", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Burkina Faso", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Mali", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),


        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best storage option for harvested Maize grains in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Government Regional warehouses", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top three varieties of Maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Obaatanpa", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Mamaba", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Dupont Pioneer Hybrid", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(30)),

              ],
    );
  }


  Widget ghanaRiceSearchResults(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Rainfall pattern for Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width:  MediaQuery.of(context).size.width -  ScreenUtil.instance.setWidth(60),
          height: ScreenUtil.instance.setHeight(250),
          child: Image.asset("assets/images/graph.png", fit: BoxFit.cover),
        ),

        
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Squalls occur in the northern part of Ghana during March and April.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Followed by occasional rain until August and September, when the rainfall reaches its peak.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        
        Container(
          
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Average amount of rainfall in mm for Northern Region, Ghana", style: TextStyle(height: 1.2, fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• 78 to 216 centimeters (31 to 85 inches) a year", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Average regional climate for Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("""The climate of the region is relatively dry, with a single rainy season that begins in May and ends in October. The amount of rainfall recorded annually varies between 750 mm and 1050 mm. The dry season starts in November and ends in March/April with maximum temperatures occurring towards the end of the dry season (March-April) and minimum temperatures in
The main vegetation is classified as vast areas of grassland, interspersed with the guinea savannah woodland, characterized by drought-resistant trees such as the acacia, baobab, shea nut, dawadawa, mango, neem
          """, style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Specific natural disasters that affect Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Drought", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Bush Fires", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Frequency of the above Natural disasters in Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Bush fires in November and December when drought occurs", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Droughts occur in September and October when they do", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Floods occur July and in November", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("General soil type in Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Predominantly light textured surface horizons in which sandy loams and loams.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best propagation or farming methods for maize in Northern Region, Ghana", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
          
        ),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Broadcasting method:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Seeds are sown broadcast by hand. This method is practised in those areas which are comparatively dry and less fertile and do not have much labour to work in the fields. It is the easiest method requiring minimum input but its yields are also minimum.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Drilling method:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Ploughing of land and sowing of seeds is done by two persons. This method is mostly confined to peninsular India.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b")) ),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Transplantation method:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("This method is practiced in areas of fertile soil, abundant rainfall and plentiful supply of labour. To begin with, seeds are sown in nursery and seedlings are prepared. After 4-5 weeks the seedlings are uprooted and planted in the field which has already been prepared for the purpose. The entire process is done by hand. It is, therefore, a very difficult method and requires heavy inputs. But at the same time it gives some of the highest yields.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b")) ),textAlign: TextAlign.justify,
          ),
        ),

//         SizedBox(height: ScreenUtil.instance.setHeight(10)),
//         Container(
//           width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
//           child: Text("""A measuring tape is used to mark 25cm/40cm depending on maize variety along a measuring line for the distances between the seeds. A second measuring line is measured at a distance of 75cm/80cm/90cm between rows depending on maize variety. 
// A planting stick is used to make two holes at the same time, one at a depth of 5cm for seed and the other at a depth of 10cm for an application of 10g of fertilizer.
// Place the seed and make the final covering. Make sure that the seed is well holed in to ensure good contact with moisture. All seeds must be well covered.
//           """, style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
//           fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
//           ),
//         ),

        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Mechanical planting", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("""This type of planting has the advantage of being quick, and if well supervised will give excellent results. However, if it is poorly supervised, it will give poor-to-disastrous results. It allows you to plant a large acreage within your pre-determined planting period. Adapt a spacing compatible with other mechanical operations like fertilizer application and weeding. Check the machine well before the anticipated planting date to make proper adjustment. Always read the operator's manual and seek advice from the suppliers for effective usage. Every season, make sure that the planter is calibrated to avoid making costly mistakes.
        //   """, style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("Below are some guidelines for calibration:", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        //   Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Each planter must be tested separately.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
          
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Select plates that will allow the largest seed of your seed sample to go through. Make sure the plate does not allow two seeds at a time.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Make sure that the driving wheel drops seeds in the furrow opener.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        // SizedBox(height: ScreenUtil.instance.setHeight(10)),
        // Container(
        //   width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
        //   child: Text("• Count the number of seeds dropped by the planter over a measured length in the field at a set driving speed. The number can be multiplied to get total number dropped / ha. The correct operating speed is normally indicated in the operator's manual e.g. 5 km/h.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
        //   fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
        //   ),
        // ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),

        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historical planting time for rice in Northern Region, GHANA.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Major Season: June", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Minor Season: The third week of August to end of September. ", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        
         SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best planting time for rice in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• June ", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historical Harvesting time for rice in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• October", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best Harvesting time for rice in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
         Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• October", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),




        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two natural fertilizer options for rice in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Cow dung", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Chicken manure", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          
        ),



        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Common Rice crop disease to expect during the farming season in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Rice Streak", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Northern leaf blight", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),

          SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Common Rice crop pests to expect during the farming season in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Rice bug", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Africa Rice gall midge", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),



         SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top three Rice crop pests to expect during the farming season in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Fall Armyworms", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Africa Rice gall midge", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Rice bug", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
          ),


        
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two chemical fertilizer options for Rice in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("In general, rates of applications per hectare in Ghana average around 90 kg N. 60 kg P2O5 and 60 kg K2O. However, fertilizer N levels up to 120 kg/ha are recommended for cultivation in degraded soils.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),




        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best soil type for rice in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Clayey loam soil", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Agric policy in direct relation to Roce in Nothern Region, Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Government intends to construct a 1, 000 metric tonne capacity warehouse in each district to provide handling and storage space for the surpluses which are anticipated. In order for the surpluses not to stay in the warehouses for long and to encourage the consumption of local food, the Ministry of Food and Agriculture will enter into agreements with the Ministries of Gender, Education and Health to purchase foodstuffs for the School Feeding Programme, for colleges, hospitals and other state institutions.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Type of government subsidy for rice in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("""For the compound fertilizer of 50kg/ha, out of the full cost of Gh¢115.00 government subsidy amounts to Gh¢26.00 thus pegging the selling price at Gh¢89.00, representing 26% in price reduction while for Urea, government subsidy on 50kg/ha costing Gh¢105.00 was Gh¢21.00, representing a 20% of subsidy. 
The market prices for both the compound fertilizer and the urea were Gh¢89.00 per 50kg bag and Gh¢84.00 per 50 kg bag, respectively. By these price reductions, it is estimated that government is subsidizing fertilizer at an average of 21%.""", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Lowest Market price over the past three years for Rice in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("GHS 96 for a Bag of maize", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Highest Market price over the past three years for Maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("GHS 115 for a Bag of maize", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),


        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best Market price over the past two years for Maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("GHS 175 for a Bag of maize", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
          
        
         SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Historically best month to sell harvested maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• May", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• August", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: ScreenUtil.instance.setHeight(20)),
    
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top two areas of demand for maize from Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
        
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Accra", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Kumasi", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Takoradi", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top countries of demand for maize from Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• IvoryCoast", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Burkina Faso", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Mali", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),


        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Best storage option for harvested Maize grains in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Government Regional warehouses", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: ScreenUtil.instance.setHeight(20)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("Top three varieties of Maize in Northern region Ghana.", style: TextStyle(fontSize: ScreenUtil.instance.setSp(34),
          fontFamily: "PlayFair", fontWeight: FontWeight.bold),
          ),
        ),
         SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Obaatanpa", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Mamaba", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(10)),
        Container(
          width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50.0),
          child: Text("• Dupont Pioneer Hybrid", style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),
          fontFamily: "Roboto", height: 1.2,color: Color(getColorHexFromStr("#777a7b"))),textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: ScreenUtil.instance.setHeight(30)),

              ],
    );
  }



 
  Widget middleSectionWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(25.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: ScreenUtil.instance.setHeight(14.0),),
          Text("Farmers Friend Day One Guidance", style: TextStyle(fontFamily: "PlayFair", 
          fontSize: ScreenUtil.instance.setSp(36.0), fontWeight: FontWeight.bold),),
           SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
           Container(
             height: ScreenUtil.instance.setHeight(130),
             width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50),
             child: Card(
               color: Colors.white,
               elevation: 2,
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(20.0),
                 vertical: ScreenUtil.instance.setHeight(10.0)),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text("Land", style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
                     fontSize: ScreenUtil.instance.setSp(32)),),
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
                                  Text("Check soil type", style: TextStyle(fontFamily: "Roboto",
                     fontSize: ScreenUtil.instance.setSp(24), color: Color(getColorHexFromStr("#777a7b")))),
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
                                  Text("Map Your Land", style: TextStyle(fontFamily: "Roboto",
                     fontSize: ScreenUtil.instance.setSp(24), color: Color(getColorHexFromStr("#777a7b")))),
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
               ),
             ),
           ),
           SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
           Container(
             height: ScreenUtil.instance.setHeight(90),
             width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50),
             child: Card(
               color: Colors.white,
               elevation: 2,
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(20.0),
                 vertical: ScreenUtil.instance.setHeight(10.0)),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text("Budget", style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
                     fontSize: ScreenUtil.instance.setSp(32)),),
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
                                  Text("How much money are you farming with ?", style: TextStyle(fontFamily: "Roboto",
                     fontSize: ScreenUtil.instance.setSp(24), color: Color(getColorHexFromStr("#777a7b")))),
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
               ),
             ),
           ),
           SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
           Container(
             height: ScreenUtil.instance.setHeight(230),
             width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50),
             child: Card(
               color: Colors.white,
               elevation: 2,
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(20.0),
                 vertical: ScreenUtil.instance.setHeight(10.0)),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text("Select Seeds", style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
                     fontSize: ScreenUtil.instance.setSp(32)),),
                     SizedBox(height: ScreenUtil.instance.setHeight(7),),
                     Container(
                       color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
                       height: ScreenUtil.instance.setHeight(50),
                       child: TextField(
                         decoration: InputDecoration(
                           labelText: "Seed Name One",
                           labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                           fontSize: ScreenUtil.instance.setSp(24)),
                           border: OutlineInputBorder(
                             borderSide: BorderSide(
                               color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.2)
                             ),
                           )
                         ),
                       ),
                     ),
                     SizedBox(height: ScreenUtil.instance.setHeight(7.0),),
                     Container(
                       color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
                       height: ScreenUtil.instance.setHeight(50),
                       child: TextField(
                         decoration: InputDecoration(
                           labelText: "Seed Name Two",
                           labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                           fontSize: ScreenUtil.instance.setSp(24)),
                           border: OutlineInputBorder(

                           )
                         ),
                       ),
                     ),
                     SizedBox(height: ScreenUtil.instance.setHeight(7.0),),
                     Container(
                       color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
                       height: ScreenUtil.instance.setHeight(50),
                       child: TextField(
                         decoration: InputDecoration(
                           labelText: "Seed Name Three",
                           labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                           fontSize: ScreenUtil.instance.setSp(24)),
                           border: OutlineInputBorder(

                           )
                         ),
                       ),
                     ),
                     
                   ],
                 ),
               ),
             ),
           ),
        ],
      ),
    );
  }
  
  Widget topVideoRow(){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
            height: ScreenUtil.instance.setHeight(150),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: ScreenUtil.instance.setHeight(150),
            decoration: BoxDecoration(
             color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.15)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric( horizontal: ScreenUtil.instance.setWidth(25.0),
              vertical: ScreenUtil.instance.setHeight(15.0),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.arrow_back, size: 20,),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          Text(username, style: TextStyle(fontSize: 14, fontFamily: "PlayFair", fontWeight: FontWeight.bold),),
                          SizedBox(width: 3.0,),
                          Text(country, style: TextStyle(fontSize: 14, fontFamily: "PlayFair", fontWeight: FontWeight.bold),),
                          SizedBox(width: 3.0,),
                          Container(
                            height: 14,
                            width: 18,
                            child: Image.asset(country == "India" ? "assets/images/in.png": "assets/images/flag_ghana.png",),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil.instance.setHeight(3),),
                  ScopedModelDescendant<CropModel>(
                    builder: (context, child, model)=> model.crop == null ?  Text("No Crop Selected", style: TextStyle(fontSize: 16, fontFamily: "Oxygen",
                          fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.3))): Text(model.crop, style: TextStyle(fontFamily: "PlayFair", fontSize: ScreenUtil.instance.setSp(36.0),
                    fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: ScreenUtil.instance.setHeight(2),),
                  // Text("Zea mays", style: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                  // fontSize: ScreenUtil.instance.setSp(18)),)
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: ScopedModelDescendant<CropModel>(
                    builder: (context, child, model)=> model.crop == null ? Container(): Container(
                  child: model.crop == "Maize" ? ( Image.asset("assets/images/maize.png", fit: BoxFit.cover))
                  : Image.asset("assets/images/rice.jpg", fit: BoxFit.cover),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: ScreenUtil.instance.setHeight(150),
                  decoration: BoxDecoration(
                    
                  ),
                //   child: YoutubePlayer(
                //     context: context,
                //     videoId: "iLnmTe5Q2Qw",
                //     flags: YoutubePlayerFlags(
                //       autoPlay: true,
                //       showVideoProgressIndicator: true,
                //     ),
                //     videoProgressIndicatorColor: Colors.amber,
                //     progressColors: ProgressColors(
                //       playedColor: Colors.amber,
                //       handleColor: Colors.amberAccent,
                //     ),
                //     onPlayerInitialized: (controller) {
                //       _controller = controller;
                //       _controller.addListener(listener);
                //     },
                // ),
                ),
          ),
        ),
        
      ],
    );
  }

  
}

class MyBullet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
    height: 6.0,
    width: 6.0,
    decoration: new BoxDecoration(
    color: Colors.black,
    shape: BoxShape.circle,
  ),
  );
  }
}