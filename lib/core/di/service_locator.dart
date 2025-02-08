import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:prime_alert/core/network/api_client.dart';
import 'package:prime_alert/core/network/config/client_config.dart';
import 'package:prime_alert/core/network/dio_client.dart';
import 'package:prime_alert/core/storage/preferences_local_storage.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';
import 'package:prime_alert/features/random/model/random_repository_remote_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static void setupLocator() async {
    locator.registerLazySingleton(() => ClientConfig.baseOptions);
    locator.registerLazySingleton(() => ClientConfig.createDio());
    locator.registerLazySingleton(() => ClientConfig.logger);
    locator.registerLazySingleton<ApiClient>(
        () => DioApiClient(locator<Dio>(), locator<PrettyDioLogger>()));
    locator.registerLazySingleton<RandomRepository>(
        () => RandomRepositoryRemoteImpl(locator<ApiClient>()));

    final sharedPreferences = await SharedPreferences.getInstance();
    locator.registerSingleton<SharedPreferences>(sharedPreferences);

    locator.registerSingleton<PreferencesLocalStorage>(
      PreferencesLocalStorage(sharedPreferences),
    );
  }
}
