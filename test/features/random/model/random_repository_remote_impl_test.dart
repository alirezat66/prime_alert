import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prime_alert/core/network/api_client.dart';
import 'package:prime_alert/core/network/network_response.dart';
import 'package:prime_alert/features/random/model/random_repository_remote_impl.dart';
import 'package:mockito/annotations.dart';
import 'random_repository_remote_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApiClient>()])
void main() {
  late RandomRepositoryRemoteImpl repository;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    repository = RandomRepositoryRemoteImpl(mockApiClient);
  });

  test('should return TimedNumber when the API call is successful', () async {
    final response = NetworkResponse(statusCode: 200, data: [7]);
    when(mockApiClient.get('random')).thenAnswer((_) async => response);

    final result = await repository.getRandomNumber();

    expect(result.number, 7);
  });

  test('should throw an exception when the API call fails', () async {
    final response =
        NetworkResponse(statusCode: 500, data: {}, errorMessage: 'error');
    when(mockApiClient.get('random')).thenAnswer((_) async => response);

    expect(() => repository.getRandomNumber(), throwsException);
  });
}
