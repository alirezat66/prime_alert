import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_alert/features/random/cubit/elapsed_time_cubit.dart';

class PrimeScreen extends StatelessWidget {
  const PrimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: BlocBuilder<ElapsedTimeCubit, Duration?>(
          builder: (context, state) {
            return Text(
              state != null ? state.inSeconds.toString() : '0',
              style: const TextStyle(fontSize: 30),
            );
          },
        ),
      ),
    );
  }
}
