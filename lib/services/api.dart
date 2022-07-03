import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather-model.dart';

class Api {
  static Future<WeatherModel?> getWeather(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = weatherModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }
}
