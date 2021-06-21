import 'package:dio/dio.dart';

class WeatherExceptions {
  String? message;

  WeatherExceptions({this.message});

  static WeatherExceptions catchError(dynamic error) {
    if (error is DioError) {
      if (error.type == DioErrorType.connectTimeout) {
        return WeatherExceptions(message: "Время ожидания истекло");
      } else if (error.type == DioErrorType.response) {
        return WeatherExceptions(message: "Ошибка в системе");
      }
    } else {
      return WeatherExceptions(message: "Произошла системная ошибка");
    }
    return WeatherExceptions(message: "Произошла ошибка сервера");
  }
}
