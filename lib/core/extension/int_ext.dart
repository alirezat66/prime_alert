extension IntExtension on int {
  bool get isPrime =>
      this > 1 &&
      List.generate(this, (index) => index + 1)
              .where((element) => this % element == 0)
              .length ==
          2;
}
