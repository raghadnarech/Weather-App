import 'package:weather_api/models/country.dart';
import 'package:weather_api/models/position_opject.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_api/models/weather_info.dart';

const Main_API_URL = "https://api.openweathermap.org/data/2.5";

const USER_KEY = "9d38eef927e7db4eb55df96a6633255d";

//Current weather api
const CURRENT_WEATHER_API = "/weather";
const LON_PARAM = "lon";
const LAT_PARAM = "lat";
const APP_ID_PARAM = "appid";
const UNITS_PARAM = "units";
const CITY_NAME_PARAM = "q";

class ApiHelper {
  static Future<WeatherInfo> getWeatherForLocation(
      PositionObject position) async {
    http.Response response = await http.get(Uri.parse(Main_API_URL +
        CURRENT_WEATHER_API +
        "?$LAT_PARAM=${position.latitude}" +
        "&$LON_PARAM=${position.longitude}" +
        "&$APP_ID_PARAM=9d38eef927e7db4eb55df96a6633255d" +
        "&$UNITS_PARAM=metric"));
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return WeatherInfo.fromJson(data);
    } else {
      return WeatherInfo.empty();
    }
  }

  static Future<WeatherInfo> getWeatherByCityName(String cityName) async {
    http.Response response = await http.get(Uri.parse(Main_API_URL +
        CURRENT_WEATHER_API +
        "?$CITY_NAME_PARAM=$cityName"
            "&$APP_ID_PARAM=9d38eef927e7db4eb55df96a6633255d" +
        "&$UNITS_PARAM=metric"));
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return WeatherInfo.fromJson(data);
    } else {
      return WeatherInfo.empty();
    }
  }

  static Future getAllCountry() async {
    http.Response response =
        await http.get(Uri.parse("https://restcountries.com/v2/all"));
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return data;
    } else {
      return [];
    }
  }
}
