import 'package:app_weather/bloc/weather_provider.dart';
import 'package:app_weather/model/weather_model.dart';

class WeatherRepository {
  Future<WeatherModel> getWeather(String city) {
    WeatherProvider provider = WeatherProvider();
    return provider.getWeather(city);
  }
}
