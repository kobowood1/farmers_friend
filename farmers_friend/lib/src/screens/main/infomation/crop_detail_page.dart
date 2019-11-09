import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CropDetailPage extends StatefulWidget {
  final String crop;
  CropDetailPage({this.crop});
  @override


  _CropDetailPageState createState() => _CropDetailPageState();
}



class _CropDetailPageState extends State<CropDetailPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: 720, height: 720
    )..init(context);

    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          height: 44,
          width: 150,
          child: new FloatingActionButton(
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          elevation: 5.0,
          child: Row(
            children: <Widget>[
              SizedBox(width: ScreenUtil.instance.setWidth(10)),
              new Image.asset("assets/images/crops.png", height: 24, width: 24,
               ),
               SizedBox(width: ScreenUtil.instance.setWidth(10)),
               Text("Start Planting", style: TextStyle(fontSize: 12, fontFamily: "Roboto", color: Colors.white)),
            ],
          ),
          backgroundColor: Color(getColorHexFromStr("#36ab80")),
          onPressed: (){
            // Navigator.push(
            //   context, MaterialPageRoute(
            //     builder: (BuildContext context){
            //       return CropDetailPage();
            //     }
            //   )
            // );
          }
    ),
    )),
    body: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        topBanner(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: ScreenUtil.instance.setHeight(20)),
              Text("")
            ],
          ),
        ),
      ],
    ),
    );
  }

  Widget topBanner(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Image.asset("assets/images/rice_banner_1.jpg", fit: BoxFit.cover),

    );
  }
}