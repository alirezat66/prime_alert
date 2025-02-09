import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:prime_alert/core/extension/int_ext.dart';
import 'package:prime_alert/features/random/model/polling_service.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';
import 'package:prime_alert/features/random/model/data/timed_number.dart';

part 'prime_number_state.dart';

class PrimeNumberCubit extends HydratedCubit<PrimeNumberState> {
  final RandomRepository _repository;
  final PollingService _pollingService;
  StreamSubscription<void>? _subscription;
  PrimeNumberCubit({
    required RandomRepository randomRepository,
    required PollingService pollingService,
  })  : _repository = randomRepository,
        _pollingService = pollingService,
        super(PrimeNumberInitial());
  @override
  PrimeNumberState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['type'] == 'found') {
        return PrimeNumberFound(
          timedNumber: TimedNumber.fromJson(json),
        );
      }
      return PrimeNumberInitial();
    } catch (_) {
      return PrimeNumberInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(PrimeNumberState state) {
    if (state is PrimeNumberFound) {
      return state.timedNumber.toJson();
    }
    return {'type': 'initial'};
  }

  void startPolling() {
    if (state is PrimeNumberFound) return;

    _subscription?.cancel();
    _subscription = _pollingService.pollingStream.listen((_) async {
      await _checkNumber();
    });
    _pollingService.startPolling();
  }

  void restartPolling() {
    emit(PrimeNumberInitial());
    startPolling();
  }

  Future<void> _checkNumber() async {
    try {
      final timedNumber = await _repository.getRandomNumber();
      if (timedNumber.number.isPrime) {
        emit(PrimeNumberFound(timedNumber: timedNumber));
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

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
