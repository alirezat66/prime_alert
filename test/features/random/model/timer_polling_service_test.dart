import 'package:flutter_test/flutter_test.dart';
import 'package:prime_alert/features/random/model/timer_polling_service.dart';

void main() {
  group('TimerPollingService', () {
    late TimerPollingService timerPollingService;

    setUp(() {
      timerPollingService = TimerPollingService(interval: Duration(milliseconds: 100));
    });

    tearDown(() {
      timerPollingService.dispose();
    });

    test('should emit events at the specified interval', () async {
      final events = <void>[];
      final subscription = timerPollingService.pollingStream.listen((event) {
        events.add(event);
      });

      timerPollingService.startPolling();

      await Future.delayed(const Duration(milliseconds: 350));
      timerPollingService.stopPolling();

      expect(events.length, greaterThanOrEqualTo(3));
      subscription.cancel();
    });

    test('should stop emitting events when stopped', () async {
      final events = <void>[];
      final subscription = timerPollingService.pollingStream.listen((event) {
        events.add(event);
      });

      timerPollingService.startPolling();
      await Future.delayed(const Duration(milliseconds: 150));
      timerPollingService.stopPolling();

      final eventCountAfterStop = events.length;

      await Future.delayed(const Duration(milliseconds: 150));
      expect(events.length, equals(eventCountAfterStop));

      subscription.cancel();
    });

    test('should close the stream controller on dispose', () async {
      timerPollingService.dispose();
      expect(timerPollingService.pollingStream.isBroadcast, isTrue);
    });
  });
}
