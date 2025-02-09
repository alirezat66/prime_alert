import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_alert/core/extensions/date_ext.dart';

class TimeCubit extends Cubit<String> {
  Timer? _timer;
  TimeCubit() : super(DateTime.now().formattedTime) {
    _initTimeStream();
  }

  void _initTimeStream() {
    final now = DateTime.now();
    final nextMinute =
        DateTime(now.year, now.month, now.day, now.hour, now.minute + 1);
    final timeUntilNextMinute = nextMinute.difference(now);
    Timer(timeUntilNextMinute, () {
      if (!isClosed) {
        updateTime();
        _timer = Timer.periodic(const Duration(minutes: 1), (_) {
          if (!isClosed) updateTime(); // ✅ Check before emitting
        });
      }
    });
  }

  void updateTime() {
    emit(DateTime.now().formattedTime);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
