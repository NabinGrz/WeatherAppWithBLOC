import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/bloc/weather-event.dart';
import 'package:weatherapp/bloc/weather-state.dart';
import 'package:weatherapp/services/api.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<WeatherTextChangedEvent>((event, emit) => {
          if (event.cityName.isEmpty)
            {emit(WeatherErrorState("Please enter city name"))}
          else
            {emit(WeatherValidState())}
        });
    on<WeatherFetchEvent>((event, emit) async {
      var weather = await Api.getWeather(event.cityName);
      if (weather == null) {
        emit(WeatherNotFoundState());
      } else {
        emit(WeatherLoadedState(weather));
      }
    });
  }
}
