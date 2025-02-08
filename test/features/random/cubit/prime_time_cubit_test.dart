import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prime_alert/features/random/cubit/elapsed_time_cubit.dart';
import 'package:prime_alert/features/random/model/data/timed_number.dart';
import 'package:prime_alert/features/random/model/prime_storage_repository.dart';

// Generate mocks for dependencies
import 'prime_number_cubit_test.mocks.dart';

@GenerateMocks([PrimeStorageRepository])
void main() {
  late ElapsedTimeCubit elapsedTimeCubit;
  late MockPrimeStorageRepository mockStorageRepository;

  setUp(() {
    mockStorageRepository = MockPrimeStorageRepository();
    elapsedTimeCubit = ElapsedTimeCubit(mockStorageRepository);
  });

  tearDown(() {
    elapsedTimeCubit.close();
  });

  blocTest<ElapsedTimeCubit, Duration?>(
    'should initialize with null state',
    build: () => elapsedTimeCubit,
    verify: (cubit) {
      expect(cubit.state, isNull);
    },
  );

  blocTest<ElapsedTimeCubit, Duration?>(
    'should start timer and update elapsed time when a prime exists',
    build: () {
      final lastPrime = TimedNumber(
          number: 7,
          responseDate: DateTime.now().subtract(const Duration(seconds: 5)));

      when(mockStorageRepository.getLastPrimeData()).thenReturn(lastPrime);

      return elapsedTimeCubit;
    },
    act: (cubit) async {
      cubit.startTimer();
      await Future.delayed(
          const Duration(seconds: 2)); // Let timer run for 2 seconds
    },
    expect: () => [
      isA<Duration>(), // First state update
      isA<Duration>(), // Second update
    ],
  );

  blocTest<ElapsedTimeCubit, Duration?>(
    'should not update if no prime exists',
    build: () {
      when(mockStorageRepository.getLastPrimeData()).thenReturn(null);
      return elapsedTimeCubit;
    },
    act: (cubit) async {
      cubit.startTimer();
      await Future.delayed(const Duration(seconds: 2)); // Let timer run
    },
    expect: () => [],
  );

  blocTest<ElapsedTimeCubit, Duration?>(
    'should stop updating when cubit is closed',
    build: () {
      final lastPrime = TimedNumber(
        number: 11,
        responseDate: DateTime.now().subtract(const Duration(seconds: 3)),
      );

      when(mockStorageRepository.getLastPrimeData()).thenReturn(lastPrime);

      return ElapsedTimeCubit(mockStorageRepository);
    },
    act: (cubit) async {
      cubit.startTimer();
      await Future.delayed(
          const Duration(seconds: 4)); // ✅ Allow multiple timer ticks
      await cubit.close();
    },
    expect: () => contains(
      isA<Duration>().having(
          (d) => d.inSeconds, 'elapsed seconds', greaterThanOrEqualTo(3)),
    ),
    verify: (_) {
      verify(mockStorageRepository.getLastPrimeData())
          .called(greaterThan(1)); // ✅ Ensure multiple fetches
    },
  );
}
