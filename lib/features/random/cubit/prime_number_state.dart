part of 'prime_number_cubit.dart';

sealed class PrimeNumberState {}

class PrimeNumberInitial extends PrimeNumberState {}

class PrimeNumberFound extends PrimeNumberState {
  final TimedNumber timedNumber;

  PrimeNumberFound({
    required this.timedNumber,
  });
}
