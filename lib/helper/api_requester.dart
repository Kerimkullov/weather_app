import 'package:app_weather/helper/weather_exception.dart';
import 'package:dio/dio.dart';

class ApiRequester {
  static String url = "http://api.openweathermap.org/data/2.5/weather";

  Future<Dio> initDio() async {
    return Dio(BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      receiveTimeout: 10000,
      connectTimeout: 10000,
    ));
  }

  Future<Response> toGet(String url, {Map<String, dynamic>? param}) async {
    Dio dio = await initDio();
    try {
      return dio.get(url, queryParameters: param);
    } catch (e) {
      throw WeatherExceptions.catchError(e);
    }
  }
}
