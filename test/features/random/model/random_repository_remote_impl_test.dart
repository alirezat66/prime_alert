import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prime_alert/core/network/api_client.dart';
import 'package:prime_alert/core/network/network_response.dart';
import 'package:prime_alert/features/random/model/random_repository_remote_impl.dart';

import 'random_repository_remote_impl_test.mocks.dart';

@GenerateMocks([ApiClient])

void main() {
  late RandomRepositoryRemoteImpl repository;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    repository = RandomRepositoryRemoteImpl(mockApiClient);
  });

  test('should return a random number when the call to API is successful', () async {
    // Arrange
    when(mockApiClient.get('random')).thenAnswer((_) async => NetworkResponse(
          statusCode: 200,
          data: [12],
        ));

    // Act
    final result = await repository.getRandomNumber();

    // Assert
    expect(result, 12);
    verify(mockApiClient.get('random')).called(1);
  });

  test('should throw an exception when the call to API is unsuccessful', () async {
    // Arrange
    when(mockApiClient.get('random')).thenAnswer((_) async => NetworkResponse(
          statusCode: 500,
          errorMessage: 'Error',
        ));

    // Act
    final call = repository.getRandomNumber();

    // Assert
    expect(() => call, throwsException);
    verify(mockApiClient.get('random')).called(1);
  });
}
