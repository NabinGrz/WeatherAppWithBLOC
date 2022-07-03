import 'package:weatherapp/model/weather-model.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weather;
  WeatherLoadedState(this.weather);
}

class WeatherErrorState extends WeatherState {
  final String errorMessage;
  WeatherErrorState(this.errorMessage);
}

class WeatherValidState extends WeatherState {}

class WeatherInValidState extends WeatherState {}

class WeatherNotFoundState extends WeatherState {}
