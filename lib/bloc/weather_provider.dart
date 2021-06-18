import 'dart:convert';

import 'package:app_weather/helper/api_requester.dart';

import 'package:app_weather/model/weather_model.dart';
import 'package:dio/dio.dart';

class WeatherProvider {
  Future<WeatherModel> getWeather(String city) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGet(
          "?appid=5452d8bda19e96bbe4ab066cddd371f8&units=metric",
          param: {"q": city});
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
      print(response.statusCode);
      throw Exception(response.statusCode);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
