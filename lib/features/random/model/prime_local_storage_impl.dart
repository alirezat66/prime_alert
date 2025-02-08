import 'package:prime_alert/core/storage/local_storage.dart';
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
  Future<DateTime?> getLastPrimeData() async {
    final dateTime = _localStorage.getString(prefLastDatePrimeHappened, '');
    try {
      return DateTime.parse(dateTime);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> savePrimeData(DateTime date) async {
    await _localStorage.setString(
        prefLastDatePrimeHappened, date.toIso8601String());
  }
}
