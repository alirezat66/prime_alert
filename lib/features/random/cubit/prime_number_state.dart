part of 'prime_number_cubit.dart';

class PrimeNumberState extends Equatable {
  final int number;
  final String error;

  const PrimeNumberState({this.number = 0, this.error = ''});
  @override
  List<Object?> get props => [number, error];

  bool get hasError => error.isNotEmpty;

  PrimeNumberState copyWith({
    int? number,
    String? error,
  }) {
    return PrimeNumberState(
      number: number ?? this.number,
      error: error ?? this.error,
    );
  }
}
