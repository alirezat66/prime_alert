import 'package:prime_alert/core/network/api_client.dart';
import 'package:prime_alert/features/random/model/data/timed_number.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';

class RandomRepositoryRemoteImpl implements RandomRepository {
  final ApiClient _apiClient;

  RandomRepositoryRemoteImpl(this._apiClient);

  @override
  Future<TimedNumber> getRandomNumber() async {
    final response = await _apiClient.get('random');
    if (response.statusCode == 200 && response.data is List) {
      return TimedNumber(
          number: response.data[0], responseDate: DateTime.now().toUtc());
    } else {
      throw Exception('Failed to fetch random number');
    }
  }
}
