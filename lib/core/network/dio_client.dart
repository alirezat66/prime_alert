// lib/network/dio_api_client.dart
import 'package:dio/dio.dart';
import 'package:prime_alert/core/network/api_client_dart';
import 'package:prime_alert/core/network/network_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;
  final PrettyDioLogger _logger;

  DioApiClient(Dio dio, PrettyDioLogger logger)
      : _dio = dio,
        _logger = logger {
    _initLogger();
  }

  void _initLogger() {
    _dio.interceptors.add(_logger);
  }

  @override
  Future<NetworkResponse> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return NetworkResponse(
        statusCode: response.statusCode ?? 200,
        data: response.data,
        errorMessage: response.statusMessage,
      );
    } catch (e) {
      return NetworkResponse(statusCode: 500, errorMessage: e.toString());
    }
  }
}
