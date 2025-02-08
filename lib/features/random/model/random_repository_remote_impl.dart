import 'package:prime_alert/core/network/api_client.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';

class RandomRepositoryRemoteImpl implements RandomRepository {
  final ApiClient _apiClient;

  RandomRepositoryRemoteImpl(this._apiClient);

  @override
  Future<int> getRandomNumber() async {
    final response = await _apiClient.get('random');
    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List).first;
    } else {
      throw Exception('Failed to fetch random number');
    }
  }
}
