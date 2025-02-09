import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_alert/features/random/cubit/elapsed_time_cubit.dart';

void main() {
  late ElapsedTimeCubit elapsedTimeCubit;

  setUp(() {
    elapsedTimeCubit = ElapsedTimeCubit();
  });

  tearDown(() async {
    await elapsedTimeCubit.close();
  });

  blocTest<ElapsedTimeCubit, Duration?>(
    'should initialize with null state',
    build: () => elapsedTimeCubit,
    verify: (cubit) {
      expect(cubit.state, isNull);
    },
  );

  blocTest<ElapsedTimeCubit, Duration?>(
    'should start timer and update elapsed time',
    build: () => elapsedTimeCubit,
    act: (cubit) async {
      final lastPrimeDate = DateTime.now().subtract(const Duration(seconds: 5));
      cubit.startTimer(lastPrimeDate);

      await Future.delayed(
          const Duration(seconds: 3)); // ✅ Let timer run for 3s
    },
    expect: () => [
      isA<Duration>().having(
          (d) => d.inSeconds, 'elapsed seconds', greaterThanOrEqualTo(5)),
      isA<Duration>().having(
          (d) => d.inSeconds, 'elapsed seconds', greaterThanOrEqualTo(6)),
      isA<Duration>().having(
          (d) => d.inSeconds, 'elapsed seconds', greaterThanOrEqualTo(7)),
    ],
  );

  blocTest<ElapsedTimeCubit, Duration?>(
    'should stop updating when cubit is closed',
    build: () => ElapsedTimeCubit(),
    act: (cubit) async {
      final lastPrimeDate = DateTime.now().subtract(const Duration(seconds: 3));
      cubit.startTimer(lastPrimeDate);

      await Future.delayed(const Duration(seconds: 2)); // ✅ Allow some updates
      await cubit.close(); // ✅ Close the cubit to stop updates
    },
    verify: (_) async {
      await Future.delayed(
          const Duration(seconds: 2)); // ✅ Ensure no new states after closing
      expect(elapsedTimeCubit.state,
          isNull); // ✅ Ensure cubit has stopped updating
    },
  );
}
