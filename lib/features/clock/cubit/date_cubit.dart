import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_alert/core/extension/date_ext.dart';

class DateCubit extends Cubit<String> {
  Timer? _timer;

  DateCubit() : super(DateTime.now().formattedDate) {
    _initDateStream();
  }

  void _initDateStream() {
    final now = DateTime.now();
    final nextDay = DateTime(now.year, now.month, now.day + 1);
    final timeUntilNextDay = nextDay.difference(now);
    Timer(timeUntilNextDay, () {
      updateDate();
      _timer = Timer.periodic(const Duration(days: 1), (_) => updateDate());
    });
  }

  updateDate() {
    emit(DateTime.now().formattedDate);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
