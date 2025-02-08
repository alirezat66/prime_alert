import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:prime_alert/core/network/api_client.dart';
import 'package:prime_alert/core/network/config/client_config.dart';
import 'package:prime_alert/core/network/dio_client.dart';
import 'package:prime_alert/core/storage/local_storage.dart';
import 'package:prime_alert/core/storage/preferences_local_storage.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';
import 'package:prime_alert/features/random/model/polling_service.dart';
import 'package:prime_alert/features/random/model/prime_local_storage_impl.dart';
import 'package:prime_alert/features/random/model/prime_storage_repository.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';
import 'package:prime_alert/features/random/model/random_repository_remote_impl.dart';
import 'package:prime_alert/features/random/model/timer_polling_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static Future<void> setupLocator(SharedPreferences sharedPreferences) async {
    locator.registerLazySingleton(() => ClientConfig.baseOptions);
    locator.registerLazySingleton(() => ClientConfig.createDio());
    locator.registerLazySingleton(() => ClientConfig.logger);
    locator.registerLazySingleton<ApiClient>(
        () => DioApiClient(locator<Dio>(), locator<PrettyDioLogger>()));
    locator.registerLazySingleton<RandomRepository>(
        () => RandomRepositoryRemoteImpl(locator<ApiClient>()));

    locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    locator.registerLazySingleton<LocalStorage>(
      () => PreferencesLocalStorage(locator<SharedPreferences>()),
    );
    locator.registerLazySingleton<PrimeStorageRepository>(
      () => PrimeLocalStorageImpl(locator<LocalStorage>()),
    );
    locator.registerLazySingleton<PollingService>(() => TimerPollingService());
    locator.registerFactory<PrimeNumberCubit>(
      () => PrimeNumberCubit(
          randomRepository: locator<RandomRepository>(),
          storageRepository: locator<PrimeStorageRepository>(),
          pollingService: locator<PollingService>()),
    );
  }
}
