import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_alert/features/random/model/prime_storage_repository.dart';

class ElapsedTimeCubit extends Cubit<Duration?> {
  final PrimeStorageRepository _storageRepository;
  ElapsedTimeCubit(PrimeStorageRepository primeStorageRepository)
      : _storageRepository = primeStorageRepository,
        super(null);
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final lastPrime = _storageRepository.getLastPrimeData();
      if (lastPrime != null) {
        emit(DateTime.now().difference(lastPrime.responseDate));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // ✅ Stop the timer before closing
    return super.close();
  }
}
