import 'package:prime_alert/features/random/model/data/timed_number.dart';

abstract class RandomRepository {
  Future<TimedNumber> getRandomNumber();
}
