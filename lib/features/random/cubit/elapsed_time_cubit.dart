import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class ElapsedTimeCubit extends Cubit<Duration?> {
  ElapsedTimeCubit() : super(null);
  Timer? _timer;

  void startTimer(DateTime lastPrimeDate) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(DateTime.now().difference(lastPrimeDate));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
