abstract class PollingService {
  Stream<void> get pollingStream;
  void startPolling();
  void stopPolling();
}
