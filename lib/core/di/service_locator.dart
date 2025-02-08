import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:prime_alert/core/network/api_client_dart';
import 'package:prime_alert/core/network/config/client_config.dart';
import 'package:prime_alert/core/network/dio_client.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static void setupLocator() {
    locator.registerLazySingleton(() => ClientConfig.baseOptions);
    locator.registerLazySingleton(() => ClientConfig.createDio());
    locator.registerLazySingleton(() => ClientConfig.logger);
    locator.registerLazySingleton<ApiClient>(() => DioApiClient(locator<Dio>(), locator<PrettyDioLogger>()));
  }
}
