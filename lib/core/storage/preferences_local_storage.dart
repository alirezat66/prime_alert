import 'package:shared_preferences/shared_preferences.dart';

class PreferencesLocalStorage {
  final SharedPreferences sharedPreferences;

  PreferencesLocalStorage(this.sharedPreferences);

  Future<bool> saveString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  Future<bool> remove(String key) {
    return sharedPreferences.remove(key);
  }

  Future<bool> clear() {
    return sharedPreferences.clear();
  }
}
