import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_alert/core/extensions/context_ext.dart';
import 'package:prime_alert/features/clock/cubit/time_cubit.dart';

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeCubit, String>(
      builder: (context, state) {
        return Text(state, style: context.textTheme.displayLarge);
      },
    );
  }
}
