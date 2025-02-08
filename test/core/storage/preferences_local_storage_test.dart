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

      when(mockSharedPreferences.setString(key, value)).thenAnswer((_) async => true);

      final result = await preferencesLocalStorage.saveString(key, value);

      expect(result, true);
      verify(mockSharedPreferences.setString(key, value)).called(1);
    });

    test('should retrieve a string value', () async {
      const key = 'testKey';
      const value = 'testValue';

      when(mockSharedPreferences.getString(key)).thenReturn(value);

      final result = preferencesLocalStorage.getString(key);

      expect(result, value);
      verify(mockSharedPreferences.getString(key)).called(1);
    });

    test('should remove a value', () async {
      const key = 'testKey';

      when(mockSharedPreferences.remove(key)).thenAnswer((_) async => true);

      final result = await preferencesLocalStorage.remove(key);

      expect(result, true);
      verify(mockSharedPreferences.remove(key)).called(1);
    });

    test('should clear all values', () async {
      when(mockSharedPreferences.clear()).thenAnswer((_) async => true);

      final result = await preferencesLocalStorage.clear();

      expect(result, true);
      verify(mockSharedPreferences.clear()).called(1);
    });
  });
}
