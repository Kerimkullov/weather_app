import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app_weather/model/weather_model.dart';

class WeatherProvider {
  Future<WeatherModel> getWeather(String city) async {
    var url = Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=Bishkek&appid=5452d8bda19e96bbe4ab066cddd371f8&units=metric");
    http.Response? response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return WeatherModel.fromJson(jsonDecode(response.body));
  }
}
