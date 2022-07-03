abstract class WeatherEvent {}

class WeatherTextChangedEvent extends WeatherEvent {
  final String cityName;
  WeatherTextChangedEvent(this.cityName);
}

class WeatherFetchEvent extends WeatherEvent {
  final String cityName;
  WeatherFetchEvent(this.cityName);
}
