abstract class LocalDTO {
  Future<void> init();

  Future<void> save(String key, String value);

  Future<String> get(String key);

  Future<void> delete(String key);

  Future<void> update(String key, String value);

  Future<List<String>> getList(String key);
  Future<void> saveList(String key, List<String> value);
}
