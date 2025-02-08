import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prime_alert/core/storage/local_storage.dart';
import 'package:prime_alert/features/random/model/data/timed_number.dart';
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
    final timedNumber = TimedNumber(number: 7, responseDate: date);
    when(localStorage.setString(
            prefLastDatePrimeHappened, timedNumber.toStringJson()))
        .thenAnswer((_) async => true);

    await primeLocalStorage.savePrimeData(timedNumber);

    verify(localStorage.setString(
            prefLastDatePrimeHappened, timedNumber.toStringJson()))
        .called(1);
  });

  test('should retrieve prime data from local storage', () {
    final date = DateTime.now();
    final timedNumber = TimedNumber(number: 7, responseDate: date);
    when(localStorage.getString(prefLastDatePrimeHappened, ''))
        .thenReturn(timedNumber.toStringJson());

    final retrievedData = primeLocalStorage.getLastPrimeData();

    expect(retrievedData!.responseDate.millisecond,
        timedNumber.responseDate.millisecond);
    expect(retrievedData.number, timedNumber.number);
  });

  test('should return null if no prime data is saved', () async {
    when(localStorage.getString(prefLastDatePrimeHappened, '')).thenReturn('');

    final retrievedData = primeLocalStorage.getLastPrimeData();

    expect(retrievedData, null);
    verify(localStorage.getString(prefLastDatePrimeHappened, '')).called(1);
  });

  test('should clear prime data from local storage', () async {
    when(localStorage.deleteKey(prefLastDatePrimeHappened))
        .thenAnswer((_) async => true);

    await primeLocalStorage.clearPrimeData();

    verify(localStorage.deleteKey(prefLastDatePrimeHappened)).called(1);
  });

  test('should check if prime data exists in local storage', () async {
    when(localStorage.hasKey(prefLastDatePrimeHappened))
        .thenAnswer((_) async => true);

    final hasKey = await primeLocalStorage.hasPrimeData();

    expect(hasKey, true);
    verify(localStorage.hasKey(prefLastDatePrimeHappened)).called(1);
  });
}
