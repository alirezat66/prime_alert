import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_alert/core/extension/int_ext.dart';
import 'package:prime_alert/features/random/model/polling_service.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';

part 'prime_number_state.dart';

class PrimeNumberCubit extends Cubit<PrimeNumberState> {
  final RandomRepository _repository;
  final PollingService _pollingService;
  StreamSubscription<void>? _subscription;
  PrimeNumberCubit({
    required RandomRepository repository,
    required PollingService pollingService,
  })  : _repository = repository,
        _pollingService = pollingService,
        super(const PrimeNumberState());

  void startPolling() {
    _subscription?.cancel();
    _subscription = _pollingService.pollingStream.listen((_) async {
      await _checkNumber();
    });
    _pollingService.startPolling();
  }

  Future<void> _checkNumber() async {
    try {
      final number = await _repository.getRandomNumber();
      if (number.isPrime) {
        emit(state.copyWith(number: number));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
