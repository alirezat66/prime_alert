import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_alert/core/di/service_locator.dart';
import 'package:prime_alert/features/clock/view/clock_screen.dart';
import 'package:prime_alert/features/random/cubit/elapsed_time_cubit.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';
import 'package:prime_alert/features/random/view/prime_screen.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<PrimeNumberCubit>()..startPolling(),
        ),
        BlocProvider(
          create: (context) => locator<ElapsedTimeCubit>(),
        ),
      ],
      child: BlocConsumer<PrimeNumberCubit, PrimeNumberState>(
        listener: (context, state) {
          if (state is PrimeNumberFound) {
            context.read<ElapsedTimeCubit>().startTimer();
          }
        },
        builder: (context, state) {
          return state is PrimeNumberFound
              ? const PrimeScreen()
              : const ClockScreen();
        },
      ),
    );
  }
}
