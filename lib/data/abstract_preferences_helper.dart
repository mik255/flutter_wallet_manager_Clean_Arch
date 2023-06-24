abstract class IPreferencesHelper {
  Future<void> saveData(String key, String data);

  Future<String?> getData(
    String key,
  );

  Future<void> deleteData(String key);
}
