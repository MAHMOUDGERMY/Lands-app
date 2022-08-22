import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
      {required String key, required bool value}) async {
    return await sharedPreferences!.setBool(key, value);
    
  }

  static Future<bool> putDataString(
      {required String key, required String value}) async {
    return await sharedPreferences!.setString(key, value);
    
  }
  static String? getDataString({required String key}) {
    return sharedPreferences!.getString(key);
  }

  static bool? getData({required String key}) {
    return sharedPreferences!.getBool(key);
  }
}
