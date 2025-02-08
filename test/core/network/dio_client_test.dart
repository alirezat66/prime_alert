import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:prime_alert/core/network/dio_client.dart';

import 'dio_client_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<Dio>(), MockSpec<PrettyDioLogger>(), MockSpec<Interceptors>()])
void main() {
  late MockDio mockDio;
  late MockPrettyDioLogger mockLogger;
  late DioApiClient dioApiClient;
  late MockInterceptors mockInterceptors;
  setUp(() {
    mockDio = MockDio();
    mockLogger = MockPrettyDioLogger();
    mockInterceptors = MockInterceptors();

    // Stub the interceptors property
    when(mockDio.interceptors).thenReturn(mockInterceptors);

    dioApiClient = DioApiClient(mockDio, mockLogger);
  });
  group('DioApiClient', () {
    test('should return NetworkResponse on successful GET request', () async {
      final response = Response(
        requestOptions: RequestOptions(path: '/test'),
        statusCode: 200,
        data: {'key': 'value'},
      );

      when(mockDio.get('/test', queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => response);

      final result = await dioApiClient.get('/test');

      expect(result.statusCode, 200);
      expect(result.data, {'key': 'value'});
      expect(result.errorMessage, isNull);
    });

    test('should return NetworkResponse with error on failed GET request',
        () async {
      when(mockDio.get('/test', queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/test'),
        error: 'Error occurred',
      ));

      final result = await dioApiClient.get('/test');

      expect(result.statusCode, 500);
      expect(result.data, isNull);
      expect(result.errorMessage,
          'DioException [unknown]: null\nError: Error occurred');
    });
  });
}
