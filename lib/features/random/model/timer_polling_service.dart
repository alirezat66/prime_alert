import 'dart:async';

import 'package:prime_alert/features/random/model/polling_service.dart';

class TimerPollingService implements PollingService {
  final Duration interval;
  final StreamController<void> _controller = StreamController<void>.broadcast();
  Timer? _timer;

  TimerPollingService({this.interval = const Duration(seconds: 10)});

  @override
  Stream<void> get pollingStream => _controller.stream;

  @override
  void startPolling() {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) {
      _controller.add(null);
    });
  }

  @override
  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stopPolling();
    _controller.close();
  }
}
