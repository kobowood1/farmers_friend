import 'package:after_layout/after_layout.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:farmers_friend/src/screens/main/home_screen.dart';
import 'package:farmers_friend/src/screens/main/pest_and_diseases/pest_and_diseases.dart';
import 'package:farmers_friend/src/utility/color_converter.dart';
import 'package:farmers_friend/src/utility/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AfterLayoutMixin<LoginScreen> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  String _currentSelectedValue = "Ghana";
  SimpleAutoCompleteTextField _countryTextField;
  List<String> added = [];
  String currentText = "";
  TextEditingController _nameTextEditController = new TextEditingController();
  TextEditingController _countryTextEditController = new TextEditingController(text: "India");
  List<String> countries = <String>["Ghana", "India"];
  int selectedCountry;

  _LoginScreenState(){
    // _countryTextField = SimpleAutoCompleteTextField(
    //   key: key,
    //   decoration: InputDecoration(
    //       // border: OutlineInputBorder(
    //       //   borderRadius: BorderRadius.all(Radius.circular(10.0))
    //       // ),
    //       contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(5.0),
    //       vertical: ScreenUtil.instance.setHeight(6.0)),
    //       labelText: "Country",
    //       labelStyle: TextStyle(color: Color(getColorHexFromStr("#bdc2c2")), 
    //       fontSize: ScreenUtil.instance.setSp(12)),
    //     ),
    //   controller: TextEditingController(text: "Starting Text"),
    //   suggestions: suggestions,
    //   textChanged: (text) => currentText = text,
    //   clearOnSubmit: true,
    //   textSubmitted: (text) => setState(() {
    //         if (text != "") {
    //           added.add(text);
    //         }
    //       }),
    // );
  }

  List<String> suggestions = <String>[
    "Ghana",
    "India",
  ];

  List<DropdownMenuItem<String>> countryList = <DropdownMenuItem<String>>[
    DropdownMenuItem<String>(child: Text("Hello"),),
    DropdownMenuItem<String>(child: Text("Hi"),),


  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) async{
    await deleteAllKeys();
  }

  Future deleteAllKeys() async{
    await deleteAllPrefs();
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
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(25.0)),
            child: Column(
              children: <Widget>[
                topLogoColumn(),
                SizedBox(height: ScreenUtil.instance.setHeight(28.0),),
                loginTextFields(),
                SizedBox(height: ScreenUtil.instance.setHeight(12.0),),
                loginRaisedButton(),
                bottomRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget countryTextField(){
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Color(getColorHexFromStr("#dedfe0")).withOpacity(0.15),
  //     ),
  //     child: IgnorePointer(
  //       ignoring: true,
  //       child: TextField(
  //         controller: countryController,
  //         decoration: InputDecoration(
  //           contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(5.0),
  //           vertical: ScreenUtil.instance.setHeight(6.0)),
  //           labelText: "Country",
  //           labelStyle: TextStyle(color: Color(getColorHexFromStr("#bdc2c2")), 
  //           fontSize: ScreenUtil.instance.setSp(12)),
  //           // border: OutlineInputBorder(
  //           //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //           // ),
  //         ),      
  //       ),
  //     ),
  //   );
  // }

  bool selectedCountryEmpty = true;


  Widget countriesDropdownWidget(){
    return DropdownButton<int>(
      value: selectedCountry,
      onChanged:(value){
        setState(() {
         selectedCountry = value; 
         selectedCountryEmpty = false;
        });
      },
      items: <DropdownMenuItem<int>>[
        DropdownMenuItem(
          value: 1,
          child: Text(countries[0], style: TextStyle(color: Colors.black, fontSize: ScreenUtil.instance.setSp(14.0))),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text(countries[1], style: TextStyle(color: Colors.black, fontSize: ScreenUtil.instance.setSp(14.0))),
        ),
        
      ],
      hint: Text("Select Country", style: TextStyle(color: Colors.black, fontSize: ScreenUtil.instance.setSp(12.0))),
      isExpanded: true,
    );
  }

  Widget loginRaisedButton(){
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
            color: Color(getColorHexFromStr("#36ab80")),
            onPressed: _nameTextEditController.text.isEmpty || _countryTextEditController.text.isEmpty ?
            null: () async{
              await saveCountryToPref(countries[selectedCountry - 1]);
              await saveNameToPref(_nameTextEditController.text);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (BuildContext context){
                  return PestAndDiseasesScreen();
                }
              ));
            },
            child: Text("Continue", style: TextStyle(color: Colors.white.withOpacity(0.8)),),
          ),
        ),
      ),
    );
  }

  Widget getDropDownCountry(){
    return FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
             // isEmpty: _currentSelectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _currentSelectedValue = newValue;
                      state.didChange(newValue);
                    });
                  },
                  items: _currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
  }

  List<String> _currencies = <String>["Ghana", "India"];

  Widget loginTextFields(){
    return Column(
      children: <Widget>[
        nameTextField(),
        SizedBox(height: ScreenUtil.instance.setHeight(12.0),),
        // countryTextField(),
        countriesDropdownWidget()
       // getDropDownCountry(),
      ],
    );
  }

  Widget bottomRow(){
    return Column(
      children: <Widget>[
        SizedBox(height: ScreenUtil.instance.setHeight(5.0),),
        Center(
          child: Container(
            height: 15,
            width: 140,
            child: Image.asset("assets/images/limitless_ai.png", fit: BoxFit.fill,),
          ),
        ),
      ],
    );
  }

  Widget nameTextField(){
    return Container(
      decoration: BoxDecoration(
        color: Color(getColorHexFromStr("#dedfe0")).withOpacity(0.2),
      ),
      child: TextField(
        controller: _nameTextEditController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(5.0),
          vertical: ScreenUtil.instance.setHeight(6.0)),
          fillColor: Color(getColorHexFromStr("#f7f8f9")),
          hoverColor: Color(getColorHexFromStr("#f7f8f9")),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(10.0))
          // ),
          labelText: "Your Name",
          labelStyle: TextStyle(color: Color(getColorHexFromStr("#bdc2c2")), 
          fontSize: ScreenUtil.instance.setSp(12)),
        ),
      ),
    );
  }

  Widget countryTextField(){
    return Container(
      decoration: BoxDecoration(
        color: Color(getColorHexFromStr("#dedfe0")).withOpacity(0.2),
      ),
      child: TextField(
        controller: _countryTextEditController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(10.0))
          // ),
          contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(5.0),
          vertical: ScreenUtil.instance.setHeight(6.0)),
          labelText: "Country",
          labelStyle: TextStyle(color: Color(getColorHexFromStr("#bdc2c2")), 
          fontSize: ScreenUtil.instance.setSp(12)),
        ),
      ),
    );
  }

  Widget topLogoColumn(){
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(40)),
      child: Column(
        children: <Widget>[

          Center(
            child: Column(
              children: <Widget>[
                Container(
                  height:70,
                  width:70,
                  child: Image.asset("assets/images/omni_ai_logo.png", fit: BoxFit.cover),
                ),
                Text("Welcome Back", style: TextStyle(color: Colors.black, fontFamily: "Playfair",
                fontSize: ScreenUtil.instance.setSp(20), fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ],
      ),
    );
  }

  
}