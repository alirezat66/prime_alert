import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:prime_alert/core/di/service_locator.dart';
import 'package:prime_alert/core/routing/app_router.dart';
import 'package:prime_alert/features/clock/cubit/date_cubit.dart';
import 'package:prime_alert/features/clock/cubit/time_cubit.dart';
import 'package:prime_alert/features/clock/view/widgets/date_view.dart';
import 'package:prime_alert/features/clock/view/widgets/timer_view.dart';
import 'package:prime_alert/features/random/cubit/prime_number_cubit.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<TimeCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<DateCubit>(),
        ),
      ],
      child: BlocListener<PrimeNumberCubit, PrimeNumberState>(
        listener: (context, state) {
          context.go(AppRouter.primePath);
        },
        child: const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TimerView(),
                Gap(24),
                DateView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
