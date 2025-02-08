part of 'prime_number_cubit.dart';

sealed class PrimeNumberState {}

class PrimeNumberInitial extends PrimeNumberState {}

class PrimeNumberFound extends PrimeNumberState {
  final TimedNumber primeData;

  PrimeNumberFound({
    required this.primeData,
  });
}
