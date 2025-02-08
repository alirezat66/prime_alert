import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';
import 'package:prime_alert/features/random/model/data/timed_number.dart';
import 'package:prime_alert/features/random/model/polling_service.dart';
import 'package:prime_alert/features/random/model/prime_storage_repository.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';

import 'prime_number_cubit_test.mocks.dart';

@GenerateMocks([RandomRepository, PollingService, PrimeStorageRepository])
void main() {
  late MockRandomRepository mockRandomRepository;
  late MockPollingService mockPollingService;
  late MockPrimeStorageRepository mockStorageRepository;
  late PrimeNumberCubit cubit;

  setUp(() {
    mockRandomRepository = MockRandomRepository();
    mockPollingService = MockPollingService();
    mockStorageRepository = MockPrimeStorageRepository();

    when(mockPollingService.pollingStream)
        .thenAnswer((_) => const Stream.empty());
    when(mockPollingService.startPolling()).thenReturn(null);
    when(mockPollingService.stopPolling()).thenReturn(null);

    cubit = PrimeNumberCubit(
      randomRepository: mockRandomRepository,
      pollingService: mockPollingService,
      storageRepository: mockStorageRepository,
    );
  });

  tearDown(() {
    cubit.close();
  });

  blocTest<PrimeNumberCubit, PrimeNumberState>(
    'should emit PrimeNumberFound when a prime number is fetched',
    build: () {
      when(mockPollingService.pollingStream).thenAnswer((_) =>
          Stream.periodic(const Duration(milliseconds: 100), (_) => null)
              .take(1));
      when(mockRandomRepository.getRandomNumber()).thenAnswer(
          (_) async => TimedNumber(number: 7, responseDate: DateTime.now()));
      when(mockStorageRepository.savePrimeData(any)).thenAnswer((_) async {});
      return cubit;
    },
    act: (cubit) async {
      cubit.startPolling();
      await cubit.stream.first; // Wait for at least one state change
    },
    expect: () => [
      isA<PrimeNumberFound>()
          .having((state) => state.primeData.number, 'prime number', 7),
    ],
  );

  blocTest<PrimeNumberCubit, PrimeNumberState>(
    'should emit PrimeNumberInitial when a non-prime number is fetched',
    build: () {
      when(mockPollingService.pollingStream).thenAnswer((_) =>
          Stream.periodic(const Duration(milliseconds: 100), (_) => null)
              .take(1));
      when(mockRandomRepository.getRandomNumber()).thenAnswer(
          (_) async => TimedNumber(number: 8, responseDate: DateTime.now()));
      when(mockStorageRepository.clearPrimeData()).thenAnswer((_) async {});
      return cubit;
    },
    act: (cubit) async {
      cubit.startPolling();
      await cubit.stream.first;
    },
    expect: () => [
      isA<PrimeNumberInitial>(),
    ],
  );
}
