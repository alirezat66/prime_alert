import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseUrl = 'https://www.randomnumberapi.com/api/v1.0/';
const timeoutDuration = Duration(seconds: 10);
const Map<String, String> headers = {
  "Content-Type": "application/json",
  "Accept": "application/json",
};
const maxLoggerWidth = 200;

class ClientConfig {
  static BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: timeoutDuration,
        headers: headers,
      );

  static PrettyDioLogger get logger => PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: maxLoggerWidth,
      );

  static Dio createDio() {
    return Dio(baseOptions);
  }
}
