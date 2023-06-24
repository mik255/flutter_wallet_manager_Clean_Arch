import 'package:shared_preferences/shared_preferences.dart';

import 'abstract_preferences_helper.dart';

class SharedPreferencesHelper implements IPreferencesHelper{

  static late SharedPreferences preferences;
  SharedPreferencesHelper(SharedPreferences preferences){
    _initPreferences();
  }
  Future<void> _initPreferences() async {
      preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveData(String key,String data) async {
    await _initPreferences();
    await preferences.setString(key, data);
  }

  @override
  Future<String?> getData(String key,) async {
    await _initPreferences();
    return preferences.getString(key);
  }

  @override
  Future<void> deleteData(String key) async {
    await _initPreferences();
    await preferences.remove(key);
  }
}
