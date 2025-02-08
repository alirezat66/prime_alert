import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prime_alert/core/storage/local_storage.dart';
import 'package:prime_alert/features/random/model/prime_local_storage_impl.dart';
import 'package:mockito/annotations.dart';
import 'prime_local_storage_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocalStorage>()])
void main() {
  late PrimeLocalStorageImpl primeLocalStorage;
  late MockLocalStorage localStorage;

  setUp(() {
    localStorage = MockLocalStorage();
    primeLocalStorage = PrimeLocalStorageImpl(localStorage);
  });

  test('should save prime data to local storage', () async {
    final date = DateTime.now();
    when(localStorage.setString(prefLastDatePrimeHappened, date.toIso8601String()))
        .thenAnswer((_) async => true);

    await primeLocalStorage.savePrimeData(date);

    verify(localStorage.setString(prefLastDatePrimeHappened, date.toIso8601String())).called(1);
  });

  test('should retrieve prime data from local storage', () async {
    final date = DateTime.now();
    when(localStorage.getString(prefLastDatePrimeHappened, ''))
        .thenReturn(date.toIso8601String());

    final retrievedDate = await primeLocalStorage.getLastPrimeData();

    expect(retrievedDate, date);
    verify(localStorage.getString(prefLastDatePrimeHappened, '')).called(1);
  });

  test('should return null if no prime data is saved', () async {
    when(localStorage.getString(prefLastDatePrimeHappened, '')).thenReturn('');

    final retrievedDate = await primeLocalStorage.getLastPrimeData();

    expect(retrievedDate, null);
    verify(localStorage.getString(prefLastDatePrimeHappened, '')).called(1);
  });

  test('should clear prime data from local storage', () async {
    when(localStorage.deleteKey(prefLastDatePrimeHappened)).thenAnswer((_) async => true);

    await primeLocalStorage.clearPrimeData();

    verify(localStorage.deleteKey(prefLastDatePrimeHappened)).called(1);
  });
}
