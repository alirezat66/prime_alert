import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_alert/core/extension/int_ext.dart';
import 'package:prime_alert/features/random/model/polling_service.dart';
import 'package:prime_alert/features/random/model/prime_storage_repository.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';
import 'package:prime_alert/features/random/model/data/timed_number.dart';

part 'prime_number_state.dart';

class PrimeNumberCubit extends Cubit<PrimeNumberState> {
  final RandomRepository _repository;
  final PollingService _pollingService;
  final PrimeStorageRepository _storageRepository;
  StreamSubscription<void>? _subscription;
  PrimeNumberCubit({
    required RandomRepository randomRepository,
    required PollingService pollingService,
    required PrimeStorageRepository storageRepository,
  })  : _repository = randomRepository,
        _pollingService = pollingService,
        _storageRepository = storageRepository,
        super(storageRepository.getLastPrimeData() != null
            ? PrimeNumberFound(primeData: storageRepository.getLastPrimeData()!)
            : PrimeNumberInitial());

  void startPolling() {
    final lastPrimeDate = _storageRepository.getLastPrimeData();
    if (lastPrimeDate != null) {
      stopPolling();
      emit(PrimeNumberFound(primeData: lastPrimeDate));
    }
    _subscription?.cancel();
    _subscription = _pollingService.pollingStream.listen((_) async {
      await _checkNumber();
    });
    _pollingService.startPolling();
  }

  void restartPooling() async {
    await _storageRepository.clearPrimeData();
    emit(PrimeNumberInitial());
    startPolling();
  }

  Future<void> _checkNumber() async {
    try {
      final timedNumber = await _repository.getRandomNumber();
      debugPrint('Number: ${timedNumber.number}');
      if (timedNumber.number.isPrime) {
        emit(PrimeNumberFound(primeData: timedNumber));
        await _storageRepository.savePrimeData(timedNumber);
        stopPolling();
      }
    } catch (_) {
      //since the document was not clear about error handling I skipped it.
    }
  }

  void stopPolling() {
    _subscription?.cancel();
    _pollingService.stopPolling();
  }
}
