import 'dart:io';
import 'dart:typed_data';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:math';


class ImageRecClass extends StatefulWidget {
  File imageFile;
  ImageRecClass({this.imageFile}); 
  @override
  _ImageRecClassState createState() => _ImageRecClassState();
}

class _ImageRecClassState extends State<ImageRecClass> {

  bool loading = false;
  List<dynamic> _recognitions;
  String _model = "";
  String bestConfidence = "";
  String diseaseName = "";

  void loadTsFile() async{
    String res = await Tflite.loadModel(
      model: "assets/plant_disease_model.tflite",
      labels: "assets/crop_labels.txt",
      numThreads: 1 // defaults to 1
    );
  }

  dynamic _pickImageError;
  String _retrieveDataError;


   @override
  void initState() {
    super.initState();

    // loading = true;

    // loadModel().then((val) {
    //   setState(() {
    //     loading = false; 
    //   });
    // });
  }

  void onSelect() async{

    await loadModel();
  }

  

  Future loadModel() async {

      String res;


          res = await Tflite.loadModel(
            model: "assets/plant_disease_model.tflite",
            labels: "assets/crop_labels.txt",
            numThreads: 2,
          );
         
      
      print("This is res:=> $res");

  }

  Future predictImagePicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      loading = true;
    });
    predictImage(image);
  }

  Future predictImage(File image) async {
    if (image == null) return;

      await recognizeImage(image);
      // await recognizeImageBinary(image);
    }

  Future recognizeImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
    });
  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading ? Center(
        child: CircularProgressIndicator()): ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Column(
            children: <Widget>[
              FutureBuilder(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot){
                  return  Column(
                    children: <Widget>[
                      Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 300,
                      child: _previewImage(),
                      
                ),  
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: <Widget>[

                      Center(
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: InkWell(
                            onTap: () async{
                              onSelect();
                              try{
                                setState(() {
                                  loading = true;
                                });
                                await recognizeImage(widget.imageFile);
                                setState(() {
                                  loading = false;
                                });
                                print(_recognitions);
                                print(_recognitions.length);
                                List<double> confidenceList = <double>[];
                                if (_recognitions.length > 1){
                                  
                                  for (Map<dynamic, dynamic> dict in _recognitions){
                                    confidenceList.add(dict["confidence"]);
                                  }
                                  double confiDouble = confidenceList.reduce(max);
                                  for (Map<dynamic, dynamic> dict in _recognitions){
                                    for (var value in dict.values.toList()){
                                      if (value == confiDouble){
                                        print("Disease ${dict["label"]}");
                                        setState(() {
                                          diseaseName = dict["label"];
                                        });
                                        print("this is the $value");
                                      }
                                    }
                                  }
                                  double confidencePercentage = confidenceList.reduce(max) * 100;
                                  // int confidence = confidencePercentage..toStringAsFixed(1);
                                  setState(() {
                                    bestConfidence = confidencePercentage.toStringAsFixed(1);
                                  });
                                }
                                else if (_recognitions.length == 1){
                                  setState(() {
                                    Map<dynamic, dynamic> dict = _recognitions[0];
                                    double confDouble = dict["confidence"] * 100;
                                    bestConfidence = confDouble.toStringAsFixed(1);
                                    // bestConfidence = confPercentage.toString();
                                    diseaseName = dict["label"];
                                  });
                                }
                                else{
                                  
                                  setState(() {
                                    diseaseName = "N/A";
                                    bestConfidence = "N/A";
                                  });
                                }
                                
                              }
                              catch(e){
                                print(e);
                              }
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(getColorHexFromStr("#36ab80")),
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              height: 40,
                              width: 150,
                              child: Center(child: Text("Detect", style: TextStyle(fontFamily: "Roboto", fontSize: 12, color: Colors.white),)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Text("Disease: $diseaseName", style: TextStyle(fontFamily: "Roboto",
                      fontSize: 16.0),)),
                      SizedBox(height: 15.0,),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Text("Confidence: $bestConfidence%", style: TextStyle(fontFamily: "Roboto",
                      fontSize: 16.0),))
                    ],
                  ),
                )
                    ],
                  );
                },
                
              ),
            ],
          ),
        ],
      )
      
      
    );
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (widget.imageFile != null) {
      return Image.file(widget.imageFile, fit: BoxFit.cover,);
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Center(
        child: const Text(
          'You have not yet picked an image.',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
        setState(() {
          widget.imageFile = response.file;
        });
      
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}