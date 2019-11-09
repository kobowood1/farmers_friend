import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}

class InformationAndGuidelinesScreen extends StatefulWidget {
  final String crop;
  final String country;
  InformationAndGuidelinesScreen({this.crop, this.country});
  @override
  _InformationAndGuidelinesScreenState createState() => _InformationAndGuidelinesScreenState();
}

class _InformationAndGuidelinesScreenState extends State<InformationAndGuidelinesScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  TextEditingController riceLandSizeTextController = new TextEditingController();
  TextEditingController riceYieldTextController = new TextEditingController();

  TextEditingController maizeLandSizeTextController = new TextEditingController();
  TextEditingController maizeYieldTextController = new TextEditingController();

  TextEditingController maizeBudgetTextController = new TextEditingController();
  TextEditingController maizeHarvestTextController = new TextEditingController();

  TextEditingController riceBudgetTextController = new TextEditingController();
  TextEditingController riceHarvestTextController = new TextEditingController();

  @override
  void initState(){
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
      'assets/cornGermination.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(
      width: 720, height: 720
    )..init(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              topVideoRow(),
              middleSectionWidget(),
            ],
          ),
        ],
      )
      
    );
  }

  Widget selectSeedBody(){
    return Padding(
                 padding: EdgeInsets.only(left: ScreenUtil.instance.setWidth(20.0),
                  right: ScreenUtil.instance.setWidth(20.0), bottom: ScreenUtil.instance.setHeight(30.0) ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                    Text("""We recommend the “AGRA-CRI-LOL-2-27” ${widget.crop} variety; “AGRA-CRI-LOL-2-27” is a high-quality and high-yielding mega variety developed by Alliance for a Green Revolution in Africa (AGRA).""", style: TextStyle(fontFamily: "Roboto", 
                    height: 1.2,  fontSize: ScreenUtil.instance.setSp(26.0),), textAlign: TextAlign.justify,),
                    
                    //  Container(
                    //    color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
                    //    height: ScreenUtil.instance.setHeight(50),
                    //    child: TextField(
                    //      decoration: InputDecoration(
                    //        labelText: "Seed Name One",
                    //        labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                    //        fontSize: ScreenUtil.instance.setSp(24)),
                    //        border: OutlineInputBorder(
                    //          borderSide: BorderSide(
                    //            color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.2)
                    //          ),
                    //        )
                    //      ),
                    //    ),
                    //  ),
                    //  SizedBox(height: ScreenUtil.instance.setHeight(7.0),),
                    //  Container(
                    //    color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
                    //    height: ScreenUtil.instance.setHeight(50),
                    //    child: TextField(
                    //      decoration: InputDecoration(
                    //        labelText: "Seed Name Two",
                    //        labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                    //        fontSize: ScreenUtil.instance.setSp(24)),
                    //        border: OutlineInputBorder(

                    //        )
                    //      ),
                    //    ),
                    //  ),
                    //  SizedBox(height: ScreenUtil.instance.setHeight(7.0),),
                    //  Container(
                    //    color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
                    //    height: ScreenUtil.instance.setHeight(50),
                    //    child: TextField(
                    //      decoration: InputDecoration(
                    //        labelText: "Seed Name Three",
                    //        labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                    //        fontSize: ScreenUtil.instance.setSp(24)),
                    //        border: OutlineInputBorder(

                    //        )
                    //      ),
                    //    ),
                    //  ),
                     
                   ],
                 ),
               );


  }


  Widget maizeSelectSeedBody(){
    return Container(
      child: widget.country == "India" ? Text("""We recommend “Ganga - II, Ganga-2 or DHM 103” maize seed variety. These maize varieties are High yielding and disease resistant.""", style: TextStyle(fontFamily: "Roboto", 
        height: 1.2,  fontSize: ScreenUtil.instance.setSp(26.0),), textAlign: TextAlign.justify,)
        :Text("""We recommend “Ganga - II, Ganga-2 or DHM 103” maize seed variety. These maize varieties are High yielding and disease resistant.""", style: TextStyle(fontFamily: "Roboto", 
        height: 1.2,  fontSize: ScreenUtil.instance.setSp(26.0),), textAlign: TextAlign.justify,),
    );
                    
  }

  Widget riceSelectSeedBody(){
    return Container(
      child: widget.country == "India" ? Text("""We recommend the “IR64” rice variety; “IR64” is a high-quality and high-yielding mega variety developed by the International Rice Research Institute (IRRI).""", style: TextStyle(fontFamily: "Roboto", 
        height: 1.2,  fontSize: ScreenUtil.instance.setSp(26.0),), textAlign: TextAlign.justify,)
        :Text("""We recommend the “AGRA-CRI-LOL-2-27” rice variety; “AGRA-CRI-LOL-2-27” is a high-quality and high-yielding mega variety developed by Alliance for a Green Revolution in Africa (AGRA).""", style: TextStyle(fontFamily: "Roboto", 
        height: 1.2,  fontSize: ScreenUtil.instance.setSp(26.0),), textAlign: TextAlign.justify,),
    );
  }

  Widget riceBudgetBody(){
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Enter budget for your ${widget.crop} farm: ", style: TextStyle(fontFamily: "PlayFair", 
                  fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
                  SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                  
                  Container(
                    color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.02),
                    height: ScreenUtil.instance.setHeight(50),
                    child: TextField(
                      style: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                        fontSize: ScreenUtil.instance.setSp(26)),
                      onChanged: (String value){
                        if (widget.country == "India"){
                            double valueD = double.parse(value);
                            double acres = valueD / 24000;
                            setState(() {
                               
                          //  riceBudgetTextController.text = "₹ $value";
                            riceHarvestTextController.text =  "$acres an arce of land";
                          });
                        }
                        else{
                          double valueD = double.parse(value);
                            double acres = valueD / 3600;
                            setState(() {
                              
                           // riceBudgetTextController.text = "GH¢ $value";
                            riceHarvestTextController.text =  "$acres arces of land";
                          });
                        }
                      },
                      inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: riceBudgetTextController,
                      decoration: InputDecoration(
                        hintText: "0.0 acres",
                        labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b"))),
                        labelText: "Land (acres)",
                        hintStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                        fontSize: ScreenUtil.instance.setSp(24)),
                        border: OutlineInputBorder(

                        )
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                  Text("You can harvest: ", style: TextStyle(fontFamily: "PlayFair", 
                  fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
                  SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                  
                  IgnorePointer(
                    ignoring: true,
                    child: Container(
                      color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.02),
                      height: ScreenUtil.instance.setHeight(50),
                      child: TextField(
                        style: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                        fontSize: ScreenUtil.instance.setSp(26)),
                        controller: riceHarvestTextController,
                        decoration: InputDecoration(
                          hintText: "0.0 tonnes",
                        hintStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                        fontSize: ScreenUtil.instance.setSp(24)),
                          border: OutlineInputBorder(

                          )
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }

  Widget maizeBudgetBody(){
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Enter budget for your ${widget.crop} farm: ", style: TextStyle(fontFamily: "PlayFair", 
                  fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
                  SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                  
                  Container(
                    color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.02),
                    height: ScreenUtil.instance.setHeight(50),
                    child: TextField(
                      style: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                        fontSize: ScreenUtil.instance.setSp(26)),
                      onChanged: (String value){
                        if (widget.country == "India"){
                            double valueD = double.parse(value);
                            double acres = valueD / 50000;
                            setState(() {
                            maizeHarvestTextController.text =  "$acres arces of land";
                          });
                        }
                        else{
                          double valueD = double.parse(value);
                            double acres = valueD / 3800;
                            setState(() {
                            maizeHarvestTextController.text =  "$acres an arce of land";
                          });
                        }
                      },
                      inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: maizeBudgetTextController,
                      decoration: InputDecoration(
                        hintText: "0.0 acres",
                        labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b"))),
                        labelText: "Land (acres)",
                        hintStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                        fontSize: ScreenUtil.instance.setSp(24)),
                        border: OutlineInputBorder(

                        )
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                  Text("You can harvest: ", style: TextStyle(fontFamily: "PlayFair", 
                  fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
                  SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                  
                  IgnorePointer(
                    ignoring: true,
                    child: Container(
                      color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.02),
                      height: ScreenUtil.instance.setHeight(50),
                      child: TextField(
                        style: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                        fontSize: ScreenUtil.instance.setSp(26)),
                        controller: maizeHarvestTextController,
                        decoration: InputDecoration(
                          hintText: "0.0 tonnes",
                        hintStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                        fontSize: ScreenUtil.instance.setSp(24)),
                          border: OutlineInputBorder(

                          )
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }

  Widget budgetBody(){
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil.instance.setWidth(20.0),
                  right: ScreenUtil.instance.setWidth(20.0), bottom: ScreenUtil.instance.setHeight(30.0) ),
      child: widget.crop == "Maize" ? maizeBudgetBody(): riceBudgetBody(),
    );
  }



  Widget landBody(){

     return Padding(
        padding: EdgeInsets.only(left: ScreenUtil.instance.setWidth(20.0),
                  right: ScreenUtil.instance.setWidth(20.0), bottom: ScreenUtil.instance.setHeight(30.0) ),
       child:   widget.crop == "Maize" ? maizeLandBody(): riceLandBody(),
     );
  }

  Widget maizeLandBody(){
    return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Text("1) Selecting Your Site For Your Maize Farm ", style: TextStyle(fontFamily: "PlayFair", 
            fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
            SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
           Text("Avoid sites with trees, ant hills, shady areas, hard pans, compacted soils, muddy and clayey soils for good yields.",
           style: TextStyle(fontFamily: "Roboto",  fontSize: ScreenUtil.instance.setSp(26), height: 1.2,color: Color(getColorHexFromStr("#777a7b"))), textAlign: TextAlign.justify,),
           SizedBox(height: ScreenUtil.instance.setHeight(20),),

           Text("2) Check the Soil Type of Selected Site", style: TextStyle(fontFamily: "PlayFair", 
            fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
            SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
           Text("We recommend planting the maize in well-drained, well-aerated, deep warm loams and silt loams containing adequate organic matter and well supplied with available nutrients. ",
           style: TextStyle(fontFamily: "Roboto",  fontSize: ScreenUtil.instance.setSp(26), height: 1.2,color: Color(getColorHexFromStr("#777a7b"))), textAlign: TextAlign.justify,),
           SizedBox(height: ScreenUtil.instance.setHeight(20),),

           Text("3) Check the Soil Temperature of Selected Site", style: TextStyle(fontFamily: "PlayFair", 
            fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
            SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
           Text("The optimum temperature for plant growth and development ranges from 30°C to 34°C. So make sure soil is warm enough but not too hot before planting.",
           style: TextStyle(fontFamily: "Roboto",  fontSize: ScreenUtil.instance.setSp(26), height: 1.2,color: Color(getColorHexFromStr("#777a7b"))), textAlign: TextAlign.justify,),
            SizedBox(height: ScreenUtil.instance.setHeight(25),),


            Text("4) Preparing Your Land for Planting Of Maize Seeds", style: TextStyle(fontFamily: "PlayFair", 
            fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
            SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
           Text("""Create your seedbed for planting using either a hoe or a cultivator machine. Maize needs to be planted carefully and accurately to achieve the best germination and emergence possible. 

Seeds will be slow to emerge or fail to germinate if the soil is too wet or dry. 
The soil should also be kept free from weeds by manual weeding or spraying as required.""",
           style: TextStyle(fontFamily: "Roboto",  fontSize: ScreenUtil.instance.setSp(26), height: 1.2,color: Color(getColorHexFromStr("#777a7b"))), textAlign: TextAlign.justify,),
            SizedBox(height: ScreenUtil.instance.setHeight(25),),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Enter land size to see ${widget.crop} yield estimate ", style: TextStyle(fontFamily: "PlayFair", 
                fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
                SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                
                Container(
                  color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.02),
                  height: ScreenUtil.instance.setHeight(50),
                  child: TextField(
                    style: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                      fontSize: ScreenUtil.instance.setSp(26)),
                    onChanged: (String value){
                      
                      
                        if (widget.country == "Ghana"){
                          double valueD = double.parse(value);
                          double bags = valueD * 80;
                          setState(() {
                            maizeYieldTextController.text =  "${bags.toString()} bags of ${widget.crop}";
                          });
                        }
                        else{
                          double valueD = double.parse(value);
                          double bags = valueD * 80;
                          setState(() {
                            maizeYieldTextController.text =  "${bags.toString()} bags of ${widget.crop}";;
                          });
                        }
                        
                      
                    },
                    inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    controller: maizeLandSizeTextController,
                    decoration: InputDecoration(
                      hintText: "0.0 acres",
                      labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b"))),
                      labelText: "Land (acres)",
                      hintStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                      fontSize: ScreenUtil.instance.setSp(24)),
                      border: OutlineInputBorder(

                      )
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                Text("You can harvest: ", style: TextStyle(fontFamily: "PlayFair", 
                fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
                SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                
                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.02),
                    height: ScreenUtil.instance.setHeight(50),
                    child: TextField(
                      style: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                      fontSize: ScreenUtil.instance.setSp(26)),
                      controller: riceYieldTextController,
                      decoration: InputDecoration(
                        hintText: "0.0 tonnes",
                      hintStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                      fontSize: ScreenUtil.instance.setSp(24)),
                        border: OutlineInputBorder(

                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
         ],
       );
  }

  Widget riceLandBody(){
    return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Text("1) Make sure the soil in the area you're planting consists of slightly acidic clay for the best results. You may also plant your ${widget.crop} seeds in plastic buckets with the same type of soil. Wherever you plant, make sure you have a reliable water source and a way to drain that water when you need to harvest.",
           style: TextStyle(fontFamily: "Roboto",  fontSize: ScreenUtil.instance.setSp(26), height: 1.2,color: Color(getColorHexFromStr("#777a7b"))), textAlign: TextAlign.justify,),
           SizedBox(height: ScreenUtil.instance.setHeight(20),),
           Text("2) Pick a location that receives full sunlight, as ${widget.crop} grows best with bright light and warm temperatures of at least 70° Fahrenheit (approximately 21° Celsius).",
           style: TextStyle(fontFamily: "Roboto",  fontSize: ScreenUtil.instance.setSp(26), height: 1.2,color: Color(getColorHexFromStr("#777a7b"))), textAlign: TextAlign.justify,),
           SizedBox(height: ScreenUtil.instance.setHeight(20),),
           Text("3) Consider the season – your area needs to allow for 3 to 6 months of plant and flower growth. ${widget.crop} needs a long, warm growing season, so a climate like the southern United States is best. If you don't have long periods of warmth, it may be best growing your ${widget.crop} inside",
           style: TextStyle(fontFamily: "Roboto",  fontSize: ScreenUtil.instance.setSp(26), height: 1.2,color: Color(getColorHexFromStr("#777a7b"))), textAlign: TextAlign.justify,),
            SizedBox(height: ScreenUtil.instance.setHeight(25),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Enter land size to see ${widget.crop} yield estimate ", style: TextStyle(fontFamily: "PlayFair", 
                fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
                SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                
                Container(
                  color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.02),
                  height: ScreenUtil.instance.setHeight(50),
                  child: TextField(
                    style: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                      fontSize: ScreenUtil.instance.setSp(26)),
                    onChanged: (String value){
                      double valueD = double.parse(value);
                      double tonnes = valueD * 2;
                      setState(() {
                        
                        riceYieldTextController.text =  "${tonnes.toString()} tonnes of ${widget.crop} yield on the average";
                      });
                    },
                    inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    controller: riceLandSizeTextController,
                    decoration: InputDecoration(
                      hintText: "0.0 acres",
                      labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b"))),
                      labelText: "Land (acres)",
                      hintStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                      fontSize: ScreenUtil.instance.setSp(24)),
                      border: OutlineInputBorder(

                      )
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                Text("You can harvest: ", style: TextStyle(fontFamily: "PlayFair", 
                fontSize: ScreenUtil.instance.setSp(32.0), fontWeight: FontWeight.bold),),
                SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
                
                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.02),
                    height: ScreenUtil.instance.setHeight(50),
                    child: TextField(
                      style: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                      fontSize: ScreenUtil.instance.setSp(26)),
                      controller: riceYieldTextController,
                      decoration: InputDecoration(
                        hintText: "0.0 tonnes",
                      hintStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
                      fontSize: ScreenUtil.instance.setSp(24)),
                        border: OutlineInputBorder(

                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
          //  Container(
          //    height: ScreenUtil.instance.setHeight(130),
          //    width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50),
          //    child: Card(
          //      color: Colors.white,
          //      elevation: 2,
          //      child: Padding(
          //        padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(20.0),
          //        vertical: ScreenUtil.instance.setHeight(10.0)),
          //        child: Column(
          //          crossAxisAlignment: CrossAxisAlignment.start,
          //          children: <Widget>[
          //            Text("Land", style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
          //            fontSize: ScreenUtil.instance.setSp(32)),),
          //            Material(
          //              child: InkWell(
          //                onTap: (){

          //                },
          //                child: Container(
          //                  color: Colors.white.withOpacity(0.5).withOpacity(0.5),
          //                  height: ScreenUtil.instance.setHeight(40),
          //                  width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(90),
          //                   child: Center(
          //                     child: Row(
          //                       children: <Widget>[
          //                         Text("Check soil type", style: TextStyle(fontFamily: "Roboto",
          //            fontSize: ScreenUtil.instance.setSp(24), color: Color(getColorHexFromStr("#777a7b")))),
          //                         Spacer(),
          //                         Icon(Icons.arrow_forward_ios, size: 18, color: Color(getColorHexFromStr("#c9ced6")),)
          //                       ],
          //                     ),
          //                   ),
          //                ),
                         
          //              ),
          //            ),
          //            Material(
          //              child: InkWell(
          //                onTap: (){

          //                },
          //                child: Container(
          //                  color: Colors.white.withOpacity(0.5),
          //                  height: ScreenUtil.instance.setHeight(40),
          //                  width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(90),
          //                   child: Center(
          //                     child: Row(
          //                       children: <Widget>[
          //                         Text("Map Your Land", style: TextStyle(fontFamily: "Roboto",
          //            fontSize: ScreenUtil.instance.setSp(24), color: Color(getColorHexFromStr("#777a7b")))),
          //                         Spacer(),
          //                         Icon(Icons.arrow_forward_ios, size: 18, color: Color(getColorHexFromStr("#c9ced6")),)
          //                       ],
          //                     ),
          //                   ),
          //                ),
                         
          //              ),
          //            ),
          //          ],
          //        ),
          //      ),
          //    ),
          //  ),
           Container(
             child: new SafeArea(
              child: new Material(
                child: new ExpansionList(
                  [
                    new ListItem(
                        title: "Land",
                        bodyBuilder: (context) => landBody()),
                    new ListItem(
                        title: "Budget",
                        subtitle: "",
                        bodyBuilder: (context) => budgetBody(),
                        isExpandedInitially: false),
                    new ListItem(
                        title: "Select Seed",
                        subtitle: "",
                        bodyBuilder: (context) => selectSeedBody(),
                        isExpandedInitially: false),
                    
                  ],
                ),
              ),
          ),
           ),
           SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
          //  Container(
          //    height: ScreenUtil.instance.setHeight(90),
          //    width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50),
          //    child: Card(
          //      color: Colors.white,
          //      elevation: 2,
          //      child: Padding(
          //        padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(20.0),
          //        vertical: ScreenUtil.instance.setHeight(10.0)),
          //        child: Column(
          //          crossAxisAlignment: CrossAxisAlignment.start,
          //          children: <Widget>[
          //            Text("Budget", style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
          //            fontSize: ScreenUtil.instance.setSp(32)),),
          //            Material(
          //              child: InkWell(
          //                onTap: (){

          //                },
          //                child: Container(
          //                  color: Colors.white.withOpacity(0.5),
          //                  height: ScreenUtil.instance.setHeight(40),
          //                  width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(90),
          //                   child: Center(
          //                     child: Row(
          //                       children: <Widget>[
          //                         Text("How much money are you farming with ?", style: TextStyle(fontFamily: "Roboto",
          //            fontSize: ScreenUtil.instance.setSp(24), color: Color(getColorHexFromStr("#777a7b")))),
          //                         Spacer(),
          //                         Icon(Icons.arrow_forward_ios, size: 18, color: Color(getColorHexFromStr("#c9ced6")),)
          //                       ],
          //                     ),
          //                   ),
          //                ),
                         
          //              ),
          //            ),
          //          ],
          //        ),
          //      ),
          //    ),
          //  ),
          //  SizedBox(height: ScreenUtil.instance.setHeight(10.0),),
          //  Container(
          //    height: ScreenUtil.instance.setHeight(230),
          //    width: MediaQuery.of(context).size.width - ScreenUtil.instance.setWidth(50),
          //    child: Card(
          //      color: Colors.white,
          //      elevation: 2,
          //      child: Padding(
          //        padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(20.0),
          //        vertical: ScreenUtil.instance.setHeight(10.0)),
          //        child: Column(
          //          crossAxisAlignment: CrossAxisAlignment.start,
          //          children: <Widget>[
          //            Text("Select Seeds", style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
          //            fontSize: ScreenUtil.instance.setSp(32)),),
          //            SizedBox(height: ScreenUtil.instance.setHeight(7),),
          //            Container(
          //              color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
          //              height: ScreenUtil.instance.setHeight(50),
          //              child: TextField(
          //                decoration: InputDecoration(
          //                  labelText: "Seed Name One",
          //                  labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
          //                  fontSize: ScreenUtil.instance.setSp(24)),
          //                  border: OutlineInputBorder(
          //                    borderSide: BorderSide(
          //                      color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.2)
          //                    ),
          //                  )
          //                ),
          //              ),
          //            ),
          //            SizedBox(height: ScreenUtil.instance.setHeight(7.0),),
          //            Container(
          //              color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
          //              height: ScreenUtil.instance.setHeight(50),
          //              child: TextField(
          //                decoration: InputDecoration(
          //                  labelText: "Seed Name Two",
          //                  labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
          //                  fontSize: ScreenUtil.instance.setSp(24)),
          //                  border: OutlineInputBorder(

          //                  )
          //                ),
          //              ),
          //            ),
          //            SizedBox(height: ScreenUtil.instance.setHeight(7.0),),
          //            Container(
          //              color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.05),
          //              height: ScreenUtil.instance.setHeight(50),
          //              child: TextField(
          //                decoration: InputDecoration(
          //                  labelText: "Seed Name Three",
          //                  labelStyle: TextStyle(color: Color(getColorHexFromStr("#777a7b")),
          //                  fontSize: ScreenUtil.instance.setSp(24)),
          //                  border: OutlineInputBorder(

          //                  )
          //                ),
          //              ),
          //            ),
                     
          //          ],
          //        ),
          //      ),
          //    ),
          //  ),
        ],
      ),
    );
  }
  
  Widget topVideoRow(){
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: (){
            // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
              height: ScreenUtil.instance.setHeight(150),
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: ScreenUtil.instance.setHeight(150),
            decoration: BoxDecoration(
              color: Color(getColorHexFromStr("#777a7b")).withOpacity(0.2)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric( horizontal: ScreenUtil.instance.setWidth(25.0),
              vertical: ScreenUtil.instance.setHeight(15.0),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 25,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(getColorHexFromStr("#f7b500"))
                    ),
                    child: Center(
                      child: Text("Day One", style: TextStyle(
                        fontFamily: "Roboto", color: Colors.white, fontSize: ScreenUtil.instance.setSp(16)
                      ),),
                    ),
                  ),
                  SizedBox(height: ScreenUtil.instance.setHeight(3),),
                  Text("${widget.crop}", style: TextStyle(fontFamily: "PlayFair", fontSize: ScreenUtil.instance.setSp(36.0),
                  fontWeight: FontWeight.bold),),
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
          child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: ScreenUtil.instance.setHeight(150),
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.blue
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
        )
      ],
    );
  }
}







class ListItem {
  final WidgetBuilder bodyBuilder;
  final String title;
  final String subtitle;
  bool isExpandedInitially;

  ListItem({
    @required this.bodyBuilder,
    @required this.title,
    this.subtitle = "",
    this.isExpandedInitially = false,
  })  : assert(title != null),
        assert(bodyBuilder != null);

  ExpansionPanelHeaderBuilder get headerBuilder =>
      (context, isExpanded) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              new SizedBox(width: 100.0, child: new Text(title, style: TextStyle(fontFamily: "PlayFair", fontWeight: FontWeight.bold,
                     fontSize: ScreenUtil.instance.setSp(32)),)),
              new Text(subtitle)
            ]),
      );
}

class ExpansionList extends StatefulWidget {
  /// The items that the expansion list should display; this can change
  /// over the course of the object but probably shouldn't as it won't
  /// transition nicely or anything like that.
  final List<ListItem> items;

  ExpansionList(this.items) {
    // quick check to make sure there's no duplicate titles.
    assert(new Set.from(items.map((li) => li.title)).length == items.length);
  }

  @override
  State<StatefulWidget> createState() => new ExpansionListState();
}

class ExpansionListState extends State<ExpansionList> {
  Map<String, bool> expandedByTitle = new Map();

  @override
  Widget build(BuildContext context) {
    return new ExpansionPanelList(
      children: widget.items
          .map(
            (item) => new ExpansionPanel(
                headerBuilder: item.headerBuilder,
                body: new Builder(builder: item.bodyBuilder),
                isExpanded:
                    expandedByTitle[item.title] ?? item.isExpandedInitially),
          )
          .toList(growable: true),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          expandedByTitle[widget.items[index].title] = !isExpanded;
        });
      },
    );
  }
}

// void main() => runApp(
//       new MaterialApp(
//         home: new SingleChildScrollView(
//           child: new SafeArea(
//             child: new Material(
//               child: new ExpansionList(
//                 [
//                   new ListItem(
//                       title: "Title 1",
//                       subtitle: "Subtitle 1",
//                       bodyBuilder: (context) => new Text("Body 1")),
//                   new ListItem(
//                       title: "Title 2",
//                       subtitle: "Subtitle 2",
//                       bodyBuilder: (context) => new Text("Body 1"),
//                       isExpandedInitially: true)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );


