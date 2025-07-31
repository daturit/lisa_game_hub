import 'package:shared_preferences/shared_preferences.dart';

class HelperSaveData {

  static Future<bool> saveData(ModelUnlock data) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    return await sharedPreferences.setInt(data.key, data.value);
  }

  static Future<bool> saveListData(List<ModelUnlock> data) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    data.map((e) async => await sharedPreferences.setInt(e.key, e.value));
    return true;
  }

  static Future<bool> saveDataBool(String key, bool value) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(key, value);
  }

// Read Data
  static Future<int?> getData(key) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key);
  }

  static Future<bool?> getDataBool(key) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  static Future<List<int>> getListData(List<String> key) async {
    final List<int> listData = [];
    for (String e in key) {
      print(e);
      final int? value = await getData(e);
      listData.add(value ?? 0);
    }
    return listData;
  }
}

class ModelUnlock {
  ModelUnlock({required this.key, required this.value});
  String key;
  int value;
}
