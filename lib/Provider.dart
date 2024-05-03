import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model_Class.dart';

class WeatherProvider with ChangeNotifier{

  WeatherProvider(){
    getTempSharePrefrence();
    getThemeSharePrefrence();
  }
  bool isTheme = false;
  bool tempUnit = false;
  var data = searchList;
  set setTheme(value){
    isTheme = value;
    notifyListeners();
  }

  get getTheme{
    return isTheme;
  }
  set setTemp(value){
    tempUnit = value;
    notifyListeners();
  }

  get getTemp{
    return tempUnit;
  }
  setTempSharePrefrence(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('Temp', value);
  }

  getTempSharePrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tempUnit = pref.getBool('Temp') ??false;
  }


  setThemeSharePrefrence(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('Theme', value);
  }

  getThemeSharePrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isTheme = pref.getBool('Theme') ??false;
  }


}