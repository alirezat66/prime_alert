import 'package:prime_alert/features/random/model/data/timed_number.dart';

abstract class PrimeStorageRepository {
  TimedNumber? getLastPrimeData();
  Future<void> savePrimeData(TimedNumber timedNumber);
  Future<void> clearPrimeData();
}
