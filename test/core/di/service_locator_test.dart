import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:prime_alert/core/di/service_locator.dart';
import 'package:prime_alert/core/network/api_client.dart';
import 'package:prime_alert/core/network/config/client_config.dart';
import 'package:prime_alert/core/network/dio_client.dart';
import 'package:prime_alert/core/storage/local_storage.dart';
import 'package:prime_alert/core/storage/preferences_local_storage.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';
import 'package:prime_alert/features/random/model/polling_service.dart';
import 'package:prime_alert/features/random/model/prime_local_storage_impl.dart';
import 'package:prime_alert/features/random/model/prime_storage_repository.dart';
import 'package:prime_alert/features/random/model/timer_polling_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/preferences_local_storage_test.mocks.dart';

void main() {
  final locator = GetIt.instance;

  setUp(() async {
    locator.reset();
    WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
    await ServiceLocator.setupLocator(MockSharedPreferences()); // Await because setupLocator has async operations
  });

  test('should register BaseOptions', () {
    final baseOptions = locator<BaseOptions>();
    expect(baseOptions.baseUrl, baseUrl);
  });

  test('should register Dio', () {
    final dio = locator<Dio>();
    expect(dio.options.baseUrl, baseUrl);
  });

  test('should register PrettyDioLogger', () {
    final logger = locator<PrettyDioLogger>();
    expect(logger.maxWidth, maxLoggerWidth);
  });

  test('should register DioApiClient', () {
    final apiClient = locator<ApiClient>();
    expect(apiClient, isA<DioApiClient>());
  });

  // Add tests for new classes
  test('should register SharedPreferences', () {
    final sharedPreferences = locator<SharedPreferences>();
    expect(sharedPreferences, isA<SharedPreferences>());
  });

  test('should register LocalStorage', () {
    final localStorage = locator<LocalStorage>();
    expect(localStorage, isA<PreferencesLocalStorage>());
  });

  test('should register PrimeStorageRepository', () {
    final primeStorageRepository = locator<PrimeStorageRepository>();
    expect(primeStorageRepository, isA<PrimeLocalStorageImpl>());
  });

  test('should register PollingService', () {
    final pollingService = locator<PollingService>();
    expect(pollingService, isA<TimerPollingService>());
  });

  test('should register PrimeNumberCubit', () {
    final primeNumberCubit = locator<PrimeNumberCubit>();
    expect(primeNumberCubit, isA<PrimeNumberCubit>());
  });
}
