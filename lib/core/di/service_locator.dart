import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:prime_alert/core/network/api_client.dart';
import 'package:prime_alert/core/network/config/client_config.dart';
import 'package:prime_alert/core/network/dio_client.dart';
import 'package:prime_alert/features/clock/cubit/date_cubit.dart';
import 'package:prime_alert/features/clock/cubit/time_cubit.dart';
import 'package:prime_alert/features/random/cubit/elapsed_time_cubit.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';
import 'package:prime_alert/features/random/model/polling_service.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';
import 'package:prime_alert/features/random/model/random_repository_remote_impl.dart';
import 'package:prime_alert/features/random/model/timer_polling_service.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static Future<void> setupLocator() async {
    locator.registerLazySingleton(() => ClientConfig.baseOptions);
    locator.registerLazySingleton(() => ClientConfig.createDio());
    locator.registerLazySingleton(() => ClientConfig.logger);
    locator.registerLazySingleton<ApiClient>(
        () => DioApiClient(locator<Dio>(), locator<PrettyDioLogger>()));
    locator.registerLazySingleton<RandomRepository>(
        () => RandomRepositoryRemoteImpl(locator<ApiClient>()));

    locator.registerLazySingleton<PollingService>(() => TimerPollingService());
    locator.registerFactory<PrimeNumberCubit>(
      () => PrimeNumberCubit(
          randomRepository: locator<RandomRepository>(),
          pollingService: locator<PollingService>()),
    );

    locator.registerFactory<ElapsedTimeCubit>(() => ElapsedTimeCubit());

    locator.registerFactory<TimeCubit>(() => TimeCubit());
    locator.registerFactory<DateCubit>(
      () => DateCubit(),
    );
  }
}
