import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  // Save a single int value
  static Future<bool> saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  // Save a single bool value
  static Future<bool> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  // Get a single int value
  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // Get a single bool value
  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // Get list of int values by keys
  static Future<List<int>> getIntList(List<String> keys) async {
    final prefs = await SharedPreferences.getInstance();
    return keys.map((key) => prefs.getInt(key) ?? 0).toList();
  }
}
