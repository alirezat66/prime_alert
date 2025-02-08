import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:prime_alert/core/di/service_locator.dart';
import 'package:prime_alert/core/network/api_client_dart';
import 'package:prime_alert/core/network/config/client_config.dart';
import 'package:prime_alert/core/network/dio_client.dart';

void main() {
  final locator = GetIt.instance;

  setUp(() {
    locator.reset();
    ServiceLocator.setupLocator();
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
}
