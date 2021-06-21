import 'package:dio/dio.dart';

class WeatherException implements Exception {
  String? message;
  String? code;
  WeatherException({this.message, this.code});
  static WeatherException catchError(dynamic error) {
    if (error is DioError) {
      print("object111111");
      switch (error.type) {
        case DioErrorType.response:
          {
            print(error.type);
            if (error.response!.statusCode == 404) {
              return WeatherException(
                message: error
                    .response!.data["message"], //error.response.statusMessage,
              );
            }
            return WeatherException(
              message: error
                  .response!.data["message"], //error.response.statusMessage,
            );
          }
        case DioErrorType.receiveTimeout:
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
          {
            return WeatherException(message: "Истекло время ожидания операции");
          }
        case DioErrorType.other:
          {
            return WeatherException(
              message: "Проверьте соединение с интернетом",
            );
          }
        case DioErrorType.cancel:
          {
            return WeatherException(message: "Выполняемый запрос отменен");
          }
        default:
          {
            return WeatherException(
                message: "Произошла системная ошибка при ожидании операции.");
          }
      }
    } else {
      print(error);
      return WeatherException(message: "Произошла системная ошибка.");
    }
  }
}
