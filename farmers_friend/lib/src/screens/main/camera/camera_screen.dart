import 'dart:io';

import 'package:farmers_friend/src/screens/main/camera/image_detection_screen.dart';
import 'package:farmers_friend/src/screens/main/chat/widgets/const.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';



class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image;

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(
      width: 720, height: 720
    )..init(context);


    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/camera_screen_bg.png", fit: BoxFit.cover,),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil.instance.setHeight(50.0)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
      child: PhysicalModel(
                color: Color(getColorHexFromStr("#36ab80")),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                elevation: 5.0,
                child: Container(
                  height: ScreenUtil.instance.setHeight(30),
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: RaisedButton(
                    elevation: 5.0,
                    color: Color(getColorHexFromStr("#36ab80")),
                    onPressed: (){
                     showBottomSheet(
                        context: context,
                        builder: (context){
                          // return GestureDetector(
                          //   onTap: (){
                          //     Navigator.pop(context);
                          //   },
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))
                              ),
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),

                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.ideographic,
                                  children: <Widget>[
                                    Material(
                                      child: InkWell(
                                        onTap: () async{
                                           await getCamera();
                                          Navigator.pop(context);
                                          prefix0.Navigator.push(context, MaterialPageRoute(
                                            builder: (context){
                                              return ImageRecClass(imageFile: _image,);
                                            }
                                          ));
                                          
                                        },
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                height: 50,
                                                width: 50,
                                                child: Image.asset("assets/images/camera_option.png"),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text("Camera", style: TextStyle(color: Colors.black, fontSize: 14),))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                   // Spacer(),
                                    Material(
                                      child: InkWell(
                                        onTap: () async{
                                           await getImage();
                                          Navigator.pop(context);
                                          prefix0.Navigator.push(context, MaterialPageRoute(
                                            builder: (context){
                                              return ImageRecClass(imageFile: _image,);
                                            }
                                          ));
                                          
                                        },
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                                  ),
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.asset("assets/images/gallery_option.png"),
                                                ),
                                                Text("Gallery", style: TextStyle(color: Colors.black, fontSize: 14),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            
                          );
                        }
                      );
                      // buttonSheetController.close();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(

                      child: Text("Auto detect", style: TextStyle(color: Colors.white.withOpacity(0.7)),),
                    ),
                  ),
                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<File> getCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
  
    setState(() {
      _image = image;
    });
    return image;
  }

  Future<File> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  
    setState(() {
      _image = image;
    });
    return image;
  }


}

class BottomSheetBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhysicalModel(
                color: Color(getColorHexFromStr("#36ab80")),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                elevation: 5.0,
                child: Container(
                  height: ScreenUtil.instance.setHeight(30),
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: RaisedButton(
                    elevation: 5.0,
                    color: Color(getColorHexFromStr("#36ab80")),
                    onPressed: (){
                     showBottomSheet(
                        context: context,
                        builder: (context){
                          // return GestureDetector(
                          //   onTap: (){
                          //     Navigator.pop(context);
                          //   },
                          return  Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))
                              ),
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),

                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.ideographic,
                                  children: <Widget>[
                                    Container(
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset("assets/images/camera_option.png"),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text("Camera", style: TextStyle(color: Colors.black, fontSize: 14),))
                                          ],
                                        ),
                                      ),
                                    ),
                                   // Spacer(),
                                    Container(
                                      height: 80,
                                      width: 80,
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(30))
                                              ),
                                              height: 50,
                                              width: 50,
                                              child: Image.asset("assets/images/gallery_option.png"),
                                            ),
                                            Text("Gallery", style: TextStyle(color: Colors.black, fontSize: 14),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            
                          );
                        }
                      );
                      // buttonSheetController.close();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(

                      child: Text("Auto detect", style: TextStyle(color: Colors.white.withOpacity(0.7)),),
                    ),
                  ),
                ),
              ),
    );
  }
}