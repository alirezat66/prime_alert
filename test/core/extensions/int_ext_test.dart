import 'package:flutter_test/flutter_test.dart';
import 'package:prime_alert/core/extensions/int_ext.dart';

void main() {
  group('IntExtension', () {
    test('isPrime should return true for prime numbers', () {
      expect(2.isPrime, true);
      expect(3.isPrime, true);
      expect(5.isPrime, true);
      expect(7.isPrime, true);
      expect(11.isPrime, true);
    });

    test('isPrime should return false for non-prime numbers', () {
      expect(1.isPrime, false);
      expect(4.isPrime, false);
      expect(6.isPrime, false);
      expect(8.isPrime, false);
      expect(9.isPrime, false);
      expect(10.isPrime, false);
    });

    test('isPrime should return false for numbers less than 2', () {
      expect(0.isPrime, false);
      expect((-1).isPrime, false);
      expect((-2).isPrime, false);
    });
  });
}
