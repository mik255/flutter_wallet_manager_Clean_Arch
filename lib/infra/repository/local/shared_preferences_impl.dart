import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/repositories/local_storange_interface.dart';

class SharedPreferencesImpl extends LocalStorageInterface {
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
    } catch (e) {
      throw Exception('Error on get data');
    }
  }

  @override
  Future<List<String>> getAll(String key) async {
    return  _preferences.getStringList(key)??[];
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
}
