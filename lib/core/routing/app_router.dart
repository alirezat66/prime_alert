import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prime_alert/core/di/service_locator.dart';
import 'package:prime_alert/features/clock/view/clock_screen.dart';
import 'package:prime_alert/features/random/cubit/elapsed_time_cubit.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';
import 'package:prime_alert/features/random/view/prime_screen.dart';

final primeNumberCubit = locator<PrimeNumberCubit>();
final elapsedTimeCubit = locator<ElapsedTimeCubit>();

class AppRouter {
  static const String clockPath = '/';
  static const String primePath = '/prime';

  static final router = GoRouter(
    initialLocation: clockPath,
    routes: [
      GoRoute(
        path: clockPath,
        builder: (context, state) {
          primeNumberCubit.startPolling();
          return const ClockScreen();
        },
      ),
      GoRoute(
        path: primePath,
        builder: (context, state) {
          final primeState = context.read<PrimeNumberCubit>().state;
          if (primeState is PrimeNumberFound) {
            elapsedTimeCubit.startTimer(primeState.timedNumber.responseDate);
          }
          return const PrimeScreen();
        },
      ),
    ],
    redirect: (context, state) {
      // Check if we have a stored prime number
      final primeState = context.read<PrimeNumberCubit>().state;

      // If we have a prime number and we're not on the prime screen, redirect
      if (primeState is PrimeNumberFound &&
          state.matchedLocation != primePath) {
        return primePath;
      }

      // If we don't have a prime number and we're on the prime screen, redirect
      if (primeState is! PrimeNumberFound &&
          state.matchedLocation == primePath) {
        return clockPath;
      }

      return null;
    },
  );
}
