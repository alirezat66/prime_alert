import 'package:flutter_test/flutter_test.dart';
import 'package:prime_alert/core/network/config/client_config.dart';

void main() {
  group('ClientConfig', () {
    test('baseOptions should return correct BaseOptions', () {
      final baseOptions = ClientConfig.baseOptions;

      expect(baseOptions.baseUrl, baseUrl);
      expect(baseOptions.connectTimeout, timeoutDuration);
      expect(baseOptions.headers, headers);
    });

    test('logger should return correct PrettyDioLogger', () {
      final logger = ClientConfig.logger;

      expect(logger.requestHeader, true);
      expect(logger.requestBody, true);
      expect(logger.responseBody, true);
      expect(logger.responseHeader, false);
      expect(logger.error, true);
      expect(logger.compact, true);
      expect(logger.maxWidth, maxLoggerWidth);
    });

    test('createDio should return Dio with correct BaseOptions and logger', () {
      final dio = ClientConfig.createDio();
      expect(dio.options.baseUrl, baseUrl);
      expect(dio.options.connectTimeout, timeoutDuration);
      expect(dio.options.headers, headers);
    });
  });
}
