import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {

  late SharedPreferences _preferences;

  Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key,String data) async {
    await _initPreferences();
    await _preferences.setString(key, data);
  }

  Future<String?> getData(String key,) async {
    await _initPreferences();
    return _preferences.getString(key);
  }

  Future<void> deleteData(String key) async {
    await _initPreferences();
    await _preferences.remove(key);
  }
}
