import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prime_alert/core/storage/preferences_local_storage.dart';

import 'preferences_local_storage_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late PreferencesLocalStorage preferencesLocalStorage;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    preferencesLocalStorage = PreferencesLocalStorage(mockSharedPreferences);
  });

  group('PreferencesLocalStorage', () {
    test('should save a string value', () async {
      const key = 'testKey';
      const value = 'testValue';

      when(mockSharedPreferences.setString(key, value))
          .thenAnswer((_) async => true);

      final result = await preferencesLocalStorage.setString(key, value);

      expect(result, true);
      verify(mockSharedPreferences.setString(key, value)).called(1);
    });

    test('should retrieve a string value', () async {
      const key = 'testKey';
      const value = 'testValue';
      when(mockSharedPreferences.getString(key)).thenReturn(value);
      final result = preferencesLocalStorage.getString(key, value);

      expect(result, value);
    });

    test('should return default value if key does not exist', () async {
      const key = 'testKey';
      const defaultValue = 'defaultValue';

      when(mockSharedPreferences.containsKey(key)).thenReturn(false);

      final result = preferencesLocalStorage.getString(key, defaultValue);

      expect(result, defaultValue);
      verify(mockSharedPreferences.containsKey(key)).called(1);
    });

    test('should remove a value', () async {
      const key = 'testKey';

      when(mockSharedPreferences.remove(key)).thenAnswer((_) async => true);

      final result = await preferencesLocalStorage.deleteKey(key);

      expect(result, true);
      verify(mockSharedPreferences.remove(key)).called(1);
    });

    test('should check if a key exists', () async {
      const key = 'testKey';

      when(mockSharedPreferences.containsKey(key)).thenReturn(true);

      final result = await preferencesLocalStorage.hasKey(key);

      expect(result, true);
      verify(mockSharedPreferences.containsKey(key)).called(1);
    });
  });
}
