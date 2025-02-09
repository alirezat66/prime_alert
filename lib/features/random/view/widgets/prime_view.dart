import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:prime_alert/core/extension/context_ext.dart';
import 'package:prime_alert/core/extension/duration_ext.dart';
import 'package:prime_alert/features/random/cubit/elapsed_time_cubit.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';

class PrimeView extends StatelessWidget {
  const PrimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congrats!',
              style: context.textTheme.headlineMedium,
            ),
            const Gap(16),
            BlocBuilder<PrimeNumberCubit, PrimeNumberState>(
              builder: (context, state) {
                return Text(
                  'You obtained a prime number, it was: ${state is PrimeNumberFound ? state.timedNumber.number : ''}',
                  style: context.textTheme.titleLarge,
                );
              },
            ),
            const Gap(16),
            BlocBuilder<ElapsedTimeCubit, Duration?>(
              builder: (context, state) {
                return Text(
                    'Time since last prime number: ${state != null ? state.formatted : '0'}',
                    style: context.textTheme.titleLarge);
              },
            ),
          ],
        ),
      ),
    );
  }
}
