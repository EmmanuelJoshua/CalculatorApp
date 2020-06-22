import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ControlHistory {
  saveHistory(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, json.encode(value));
  }

  viewHistory(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return json.decode(sharedPreferences.getString(key));
  }

  void deleteHistory(String key) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  void editHistory() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  }
}
