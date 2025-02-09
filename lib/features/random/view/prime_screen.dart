import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prime_alert/core/routing/app_router.dart';
import 'package:prime_alert/features/random/cubit/elapsed_time_cubit.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';
import 'package:prime_alert/features/random/view/widgets/prime_view.dart';

class PrimeScreen extends StatelessWidget {
  const PrimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ElapsedTimeCubit, Duration?>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(child: PrimeView()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<PrimeNumberCubit>().restartPolling();
                      context.go(AppRouter.clockPath);
                    },
                    child: const Text(
                      'Close',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
