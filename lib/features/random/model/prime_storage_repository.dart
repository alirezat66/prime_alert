abstract class PrimeStorageRepository {
  Future<DateTime?> getLastPrimeData();
  Future<void> savePrimeData(DateTime date);
  Future<void> clearPrimeData();
}
