import 'dart:async';

import 'package:farmers_friend/src/model/Condition.dart';
import 'package:farmers_friend/src/model/WeatherData.dart';
import 'package:farmers_friend/src/network/ApiClient.dart';
import 'package:flutter_flux/flutter_flux.dart';


class WeatherStore extends Store {

  WeatherData weatherData;

  WeatherStore() {
    // TODO make loading widget from here
    this.weatherData = new WeatherData("", new Condition(id: 0, description: "Loading"));

    triggerOnAction(actionUpdateWeather, (dynamic) {
      _updateWeather();
    });
  }

  void _updateWeather() {
    var apiClient = ApiClient.getInstance();
    Future<WeatherData> fWeatherData = apiClient.getWeather();
    fWeatherData
        .then((content) {
          this.weatherData = content;
          trigger();
    }).catchError((e) {
        this.weatherData = null;
        // todo trigger error
    });
  }

}

// Token and actions
final Action actionUpdateWeather = new Action();
final StoreToken weatherStoreToken = new StoreToken(new WeatherStore());