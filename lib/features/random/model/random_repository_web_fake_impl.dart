import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:prime_alert/features/random/model/data/timed_number.dart';
import 'package:prime_alert/features/random/model/random_repository.dart';

// For solving cors problem on api
class RandomRepositoryWebFakeImpl implements RandomRepository {
  @override
  Future<TimedNumber> getRandomNumber() async {
    await Future.delayed(const Duration(milliseconds: 200));
    var random = Random();
    int randomNumber =
        random.nextInt(2000); // Generates a random number between 0 and 99
    debugPrint("Random number generated: $randomNumber");
    return TimedNumber(number: randomNumber, responseDate: DateTime.now());
  }
}
