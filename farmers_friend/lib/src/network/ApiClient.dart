import 'dart:convert';
import 'dart:io';

import 'package:farmers_friend/src/model/ForecastData.dart';
import 'package:farmers_friend/src/model/WeatherData.dart';
import 'package:farmers_friend/src/utility/prefs.dart';
import 'package:http/http.dart' as http;


import 'dart:async';

class ApiClient {
  static ApiClient _instance;

  static ApiClient getInstance() {
  //  initializeDetails();
    if (_instance == null) {
      _instance = new ApiClient();
    }
    return _instance;
  }

  int currentIndex = 0;
  static String country = "";
  static String username = "";


  // static Future initializeDetails() async{
  //   username = await getNameFromPref();
  //   country = await getCountryFromPref();
  // }


  Future<WeatherData> getWeather() async {
    username = await getNameFromPref();
    country = await getCountryFromPref();
    if (country == "Ghana"){
        http.Response response = await http.get(
      Uri.encodeFull(Endpoints.GHANA_WEATHER),
      headers: {
        "Accept": "application/json"
      }
    );

    return WeatherData.deserialize(response.body);
    }
    else{
        http.Response response = await http.get(
      Uri.encodeFull(Endpoints.INDIA_WEATHER),
      headers: {
        "Accept": "application/json"
      }
    );

    return WeatherData.deserialize(response.body);
    }

  }

  Future<ForecastData> getForecast() async {
    username = await getNameFromPref();
    country = await getCountryFromPref();
    if (country == "Ghana"){
        http.Response response = await http.get(
      Uri.encodeFull(Endpoints.GHANA_FORECAST),
      headers: {
        "Accept": "application/json"
      }
    );

    return ForecastData.deserialize(response.body);
    }
    else{
        http.Response response = await http.get(
      Uri.encodeFull(Endpoints.INDIA_FORECAST),
      headers: {
        "Accept": "application/json"
      }
    );

    return ForecastData.deserialize(response.body);
    }
    
  }

  static Future<Map<String, dynamic>> sendMessageToChatBot(String message) async{
    message = message.replaceAll(" ", "%20");
    try{
      String token = "22f3fd94577b4e058453205262e953d2";
      Map<String, String> headers = <String, String>{
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      };
      String url = "https://api.dialogflow.com/v1/query?v=20150910&sessionId=ae8389527e43455f8d42094d6fcf8e60&lang=en&query=$message";
      
      print("URL is:=> $url");
      var response = await http.get(url,
      headers: headers);
      var responseString = json.decode(response.body);
      print("Response is $responseString");
      if (responseString["result"]["actionIncomplete"] == false){
        return responseString;
      }
      return null;

    }
    catch(e){
      throw new Exception("A Fatal Exception Occured");
      
    }
  }

}

class Endpoints {
  static const _ENDPOINT = "http://api.openweathermap.org/data/2.5";
  static const GHANA_WEATHER = _ENDPOINT + "/weather?lat=7.5909&lon=1.9344&APPID=af29567e139fe06b6c2d050515cdff0c&units=metric";
  static const GHANA_FORECAST = _ENDPOINT + "/forecast?lat=7.5909&lon=1.9344&APPID=af29567e139fe06b6c2d050515cdff0c&units=metric";
  static const INDIA_WEATHER = _ENDPOINT + "/weather?lat=17.3850&lon=78.4867&APPID=af29567e139fe06b6c2d050515cdff0c&units=metric";
  static const INDIA_FORECAST = _ENDPOINT + "/forecast?lat=17.3850&lon=78.4867&APPID=af29567e139fe06b6c2d050515cdff0c&units=metric";
}