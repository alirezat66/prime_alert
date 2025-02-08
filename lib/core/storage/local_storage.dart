abstract class LocalStorage {
  Future<bool> setString(String key, String value);
  String getString(String key, String defaultValue);
  Future<bool> deleteKey(String key);
  Future<bool> hasKey(String key);
}
