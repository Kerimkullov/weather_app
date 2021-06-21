import 'dart:async';

import 'package:app_weather/bloc/weather_repository.dart';
import 'package:app_weather/helper/weather_exception.dart';
import 'package:app_weather/model/weather_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository repository = WeatherRepository();

  WeatherBloc(this.repository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    try {
      if (event is GetWeatherEvent) {
        yield WeatherInitial();
        WeatherModel data = await repository.getWeather(event.city);
        yield WeatherLoaded(data);
      }
    } catch (e) {
      yield WeatherError(WeatherExceptions.catchError(e));
    }
  }
}
