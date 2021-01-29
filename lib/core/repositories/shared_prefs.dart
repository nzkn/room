import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static const String _key_first_launch = 'first_launch';
  static const String _key_user_language = 'user_language';

  /// Setters

  static Future<bool> setFirstLaunch(bool isFirstLaunch) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_key_first_launch, isFirstLaunch);
  }

  static Future<bool> setUserLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_key_first_launch, language);
  }

  /// Getters

  static Future<bool> isFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_key_first_launch)) {
      return prefs.getBool(_key_first_launch);
    }
    return true;
  }

  static Future<String> getUserLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_key_user_language)) {
      return json.decode(prefs.getString(_key_user_language));
    }
    return 'en';
  }

  /// Remove

  static Future<bool> removeFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_key_first_launch);
  }

  static Future<bool> removeLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_key_user_language);
  }
}