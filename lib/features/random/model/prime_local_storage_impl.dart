import 'package:prime_alert/core/storage/local_storage.dart';
import 'package:prime_alert/features/random/model/data/timed_number.dart';
import 'package:prime_alert/features/random/model/prime_storage_repository.dart';

const prefLastDatePrimeHappened = 'pref_last_date_prime_happened';

class PrimeLocalStorageImpl extends PrimeStorageRepository {
  final LocalStorage _localStorage;

  PrimeLocalStorageImpl(this._localStorage);

  @override
  Future<void> clearPrimeData() async {
    await _localStorage.deleteKey(prefLastDatePrimeHappened);
  }

  @override
  TimedNumber? getLastPrimeData() {
    final randomString = _localStorage.getString(prefLastDatePrimeHappened, '');
    try {
      return TimedNumber.fromStringJson(randomString);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> savePrimeData(TimedNumber timedNumber) async {
    await _localStorage.setString(
        prefLastDatePrimeHappened, timedNumber.toStringJson());
  }

  Future<bool> hasPrimeData() async {
    return await _localStorage.hasKey(prefLastDatePrimeHappened);
  }
}
