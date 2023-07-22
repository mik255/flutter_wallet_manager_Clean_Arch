import 'package:shared_preferences/shared_preferences.dart';
import '../local_datasource.dart';


class SharedPreferencesImpl extends LocalDataSource {
  late SharedPreferences _preferences;
  @override
  Future<void> init() async {
      _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> delete(String key) async {
    await _preferences.remove(key);
  }

  @override
  Future<String> get(String key) async {
    try {
      return _preferences.getString(key)!;
    } catch (e,_) {
      print(_);
      throw Exception('Error on get data');
    }
  }

  @override
  Future<List<String>> getList(String key) async {
    return _preferences.getStringList(key)??[];
  }

  @override
  Future<void> save(String key, String value) async {
    await _preferences.setString(key, value);
  }

  @override
  Future<void> update(String key, String value) async {
    await delete(key);
    await _preferences.setString(key, value);
  }

  @override
  Future<void> saveList(String key, List<String> value) async{
    await _preferences.setStringList(key, value);
  }
}
