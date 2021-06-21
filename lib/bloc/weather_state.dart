part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel model;
  WeatherLoaded(this.model);
}

class WeatherError extends WeatherState {
  final WeatherExceptions message;
  WeatherError(this.message);
}
