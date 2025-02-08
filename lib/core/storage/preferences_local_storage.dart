import 'package:prime_alert/core/storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesLocalStorage implements LocalStorage {
  final SharedPreferences _sharedPreferences;

  PreferencesLocalStorage(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;
  @override
  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  @override
  String getString(String key, String defaultValue) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.getString(key) ?? defaultValue;
    } else {
      return defaultValue;
    }
  }

  @override
  Future<bool> deleteKey(String key) async {
    return await _sharedPreferences.remove(key);
  }

  @override
  Future<bool> hasKey(String key) {
    return Future.value(_sharedPreferences.containsKey(key));
  }
}
