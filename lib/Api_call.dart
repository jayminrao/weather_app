import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Model_Class.dart';

class apiCalling {
  WeatherModel? obj;

  Future loadApiData(city) async {
    final http.Response response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=f43c4a9b70aa4b43b5a192307240305&q=${city}&days=7&aqi=no&alerts=no'));
    var d = jsonDecode(response.body);
    obj = WeatherModel.fromJson(d);
    return obj;
  }
}