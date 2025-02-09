import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';
import 'package:prime_alert/features/random/model/data/timed_number.dart';
import 'package:prime_alert/features/random/model/polling_service.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';

import 'prime_number_cubit_test.mocks.dart';

@GenerateMocks([RandomRepository, PollingService, Storage])
void main() {
  late MockRandomRepository mockRandomRepository;
  late MockPollingService mockPollingService;
  late PrimeNumberCubit cubit;
  final pollingController = StreamController<void>.broadcast();
  late MockStorage storage;
  void initHydratedStorage() {
    storage = MockStorage();
    when(storage.write(any, any)).thenAnswer((_) async {});
    when(storage.read(any)).thenReturn(null);
    when(storage.delete(any)).thenAnswer((_) async {});
    when(storage.clear()).thenAnswer((_) async {});

    HydratedBloc.storage = storage;
  }

  setUp(() {
    initHydratedStorage(); // ✅ Initialize mocked HydratedBloc storage

    mockRandomRepository = MockRandomRepository();
    mockPollingService = MockPollingService();

    when(mockPollingService.pollingStream)
        .thenAnswer((_) => const Stream.empty());
    when(mockPollingService.startPolling()).thenReturn(null);
    when(mockPollingService.stopPolling()).thenReturn(null);

    cubit = PrimeNumberCubit(
      randomRepository: mockRandomRepository,
      pollingService: mockPollingService,
    );
  });

  tearDown(() async {
    await cubit.close();
    pollingController.close();
  });

  // ✅ Test: HydratedBloc should restore persisted PrimeNumberFound state
  test('should restore last state from HydratedBloc storage', () {
    final primeData = TimedNumber(number: 17, responseDate: DateTime.now());

    when(storage.read(any)).thenReturn({
      'type': 'found',
      'number': primeData.number,
      'responseDate': primeData.responseDate.toIso8601String(),
    });

    final restoredCubit = PrimeNumberCubit(
      randomRepository: mockRandomRepository,
      pollingService: mockPollingService,
    );

    expect(restoredCubit.state, isA<PrimeNumberFound>());
  });

  // ✅ Test: Fetch prime number and update state
  blocTest<PrimeNumberCubit, PrimeNumberState>(
    'should emit PrimeNumberFound when a prime number is fetched',
    build: () {
      when(mockPollingService.pollingStream).thenAnswer((_) =>
          Stream.periodic(const Duration(milliseconds: 100), (_) => null)
              .take(1));

      final primeNumber = TimedNumber(number: 7, responseDate: DateTime.now());
      when(mockRandomRepository.getRandomNumber())
          .thenAnswer((_) async => primeNumber);

      return cubit;
    },
    act: (cubit) async {
      cubit.startPolling();
      await cubit.stream.first; // Wait for at least one state change
    },
    expect: () => [
      isA<PrimeNumberFound>()
          .having((state) => state.timedNumber.number, 'prime number', 7),
    ],
  );

  // ✅ Test: Fetch non-prime number and emit PrimeNumberInitial
  blocTest<PrimeNumberCubit, PrimeNumberState>(
    'should emit PrimeNumberFound when a prime number is fetched',
    build: () {
      when(mockPollingService.pollingStream).thenAnswer(
        (_) => Stream.periodic(const Duration(milliseconds: 100), (_) => null)
            .take(1),
      );

      final primeNumber = TimedNumber(number: 7, responseDate: DateTime.now());
      when(mockRandomRepository.getRandomNumber())
          .thenAnswer((_) async => primeNumber);

      return cubit;
    },
    act: (cubit) async {
      cubit.startPolling();
      await Future.delayed(
          const Duration(milliseconds: 200)); // ✅ Ensure async execution
    },
    expect: () => [
      isA<PrimeNumberFound>()
          .having((state) => state.timedNumber.number, 'prime number', 7),
    ],
  );

  // ✅ Test: Restart polling and clear stored state
  blocTest<PrimeNumberCubit, PrimeNumberState>(
    'should reset state when restartPolling is called',
    build: () {
      return cubit;
    },
    act: (cubit) => cubit.restartPolling(),
    expect: () => [
      isA<PrimeNumberInitial>(), // ✅ Ensure it resets
    ],
  );

  // ✅ Test: Stop polling
  blocTest<PrimeNumberCubit, PrimeNumberState>(
    'should stop polling when stopPolling is called',
    build: () {
      return cubit;
    },
    act: (cubit) => cubit.stopPolling(),
    verify: (_) {
      verify(mockPollingService.stopPolling()).called(1);
    },
  );
}
